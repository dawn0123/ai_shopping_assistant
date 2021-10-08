#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np

import pandas as pd


# In[2]:


#set Base values
alpha = 0.01
num_R = 3


# In[3]:


def readData():
    df = pd.read_csv ('data1.csv')
    df = df.drop(['Product_Name', 'Product_Category', 'User_Location', 'User_Province', 'Cost', 'Date', 'recommend_product', 'recommend_category'], axis=1)
    df.User_ID = df.User_ID.replace(np.nan, '?')
    df['Event'] = df['Event'].replace(['view', 'wishlist', 'cart'],[1, 3, 5])
    df.rename(columns={'Product_Id':'items', 'User_ID':'users', 'Event':'rating'}, inplace=True)
    return df


# In[4]:


def getRatingsList(user_id, rating_matrix):
    pt = np.array(rating_matrix.index.get_level_values('users') == user_id).tolist()
    indices = [i for i, x in enumerate(pt) if x == True]
    ratings = rating_matrix.iloc[indices[0]]
    ans = [i for i, x in enumerate(ratings) if x == "*"]
    return ans


# In[5]:


def getUnratedProducts(ratings_list, rating_matrix):
    ans = []
    for indices in ratings_list:
        ans.append(rating_matrix.columns.values.item(indices));
    return ans


# In[6]:


def getRatings(a):
    rates = []
    rates.append(a[1])
    rates.append(a[3])
    rates.append(a[5])
    return rates


# In[7]:


def getProbability(a, b):
    numerator = a + alpha
    denominator = b + num_R*alpha
    return numerator/denominator


# In[8]:


def countNoItemsRated(unrated_products, rating_matrix):
    hash_I = []
    for prod in unrated_products:
        rates = 0
        for r in rating_matrix[prod]:
            if r != "*":
                rates = rates + 1;
        hash_I.append([prod, rates])
    return hash_I


# In[9]:


def getUserbasedProbabilities(df, unrated_products):
    occurance_matrix = pd.crosstab(df['items'],df['rating'])
    rates = getRatings(occurance_matrix)
    return pd.DataFrame(user_based(rates, unrated_products))


# In[10]:


def getItembasedProbabilities(df, unrated_products):
    occurance_matrix = pd.crosstab(df['users'],df['rating'])
    rates = getRatings(occurance_matrix)
    return pd.DataFrame(item_based(rates, unrated_products))


# In[11]:


def user_based(rates, unrated_products):
    userbased_probabilities = []
    for (prod, r_1,r_3, r_5) in zip(unrated_products, rates[0],rates[1],rates[2]):
        temp = []
        total_rated = r_1 +r_3+ r_5
        r1_probability = getProbability(r_1, total_rated)
        r3_probability = getProbability(r_3, total_rated)
        r5_probability = getProbability(r_5, total_rated)
        temp.append(prod)
        temp.append(r1_probability)
        temp.append(r3_probability)
        temp.append(r5_probability)
        userbased_probabilities.append(temp)
    return userbased_probabilities


# In[12]:


def item_based(rates, unrated_products):
    itembased_probabilities = []
    for (prod, r_1, r_3, r_5) in zip(unrated_products,rates[0],rates[1],rates[2]):
        temp = []
        total_rated = r_1 + r_3 + r_5
        r1_probability = getProbability(r_1, total_rated)
        r3_probability = getProbability(r_3, total_rated)
        r5_probability = getProbability(r_5, total_rated)
        temp.append(r1_probability)
        temp.append(r3_probability)
        temp.append(r5_probability) 
        itembased_probabilities.append(temp)
    return itembased_probabilities


# In[13]:


def UserbasedLikelihood(unrated_products, Items, rating_matrix):
    userbased_likelihoods = []

    for item in range(len(unrated_products)):
        n = 0
        while n < len(Items):
            if(unrated_products[item] != Items[n]):
                temp = []
                temp.append(unrated_products[item])        
                temp.append(Items[n])
                for r in range(5):
                    r = r + 1
                    numerator = 0
                    denominator = 0
                    for (i, j) in zip(rating_matrix.get(unrated_products[item]), rating_matrix.get(Items[n])):  
                        if i == j == r:
                            numerator = numerator + 1
                        if i == r and j != '*':
                            denominator = denominator + 1
            
                    temp.append((numerator+alpha)/(denominator+num_R*alpha))
            
                userbased_likelihoods.append(temp)
            n = n + 1
    return userbased_likelihoods


# In[14]:


def ItembasedLikelihoods(unrated_products, Users, rating_matrix):
    user = Users.index(user_id)
    temp = rating_matrix
    itembased_likelihoods = []

    temp = temp.replace('*', -1)

    for up in unrated_products:
        n = 0
        while n < len(Users):
            if(n != user):
                t = []
                t.append(up)
                t.append(Users[n])
                for r in range(1, 6):
                    numerator = 0
                    denominator = 0
                    for (i, j) in zip(temp.iloc[user], temp.iloc[n]):
                        if i == j == r:
                            numerator = numerator + 1
                        if i == r and j != -1:
                            denominator = denominator + 1
                        
                    t.append((numerator+alpha)/(denominator+num_R*alpha))
                itembased_likelihoods.append(t)    
            n = n + 1
    return itembased_likelihoods


# In[15]:


def combineAlgorithms(unrated_products, user_classifier, item_classifier, rating_matrix, Items):
    
    #get number of items rated by user
    hash_U = len(Items) - len(unrated_products)
    hash_I = countNoItemsRated(unrated_products, rating_matrix)
    
    hybrid = []
    for item in range(len(unrated_products)):
        t = []
        t.append(unrated_products[item])
        for (a, b) in zip(user_classifier.iloc[item], item_classifier.iloc[item]):
            t.append(pow(a, (1/(1+hash_U)))*pow(b, (1/(1+hash_I[item][1]))))
        hybrid.append(t)
    return pd.DataFrame(hybrid).set_index(0)


# In[16]:


def getRecommendations(unrated_products, s, hybrid):
    
    reliability = []
    for item in range(len(unrated_products)):
        t = []
        t.append(unrated_products[item])
        for a in hybrid.iloc[item]:
            t.append(a/s[0][item])
        reliability.append(t)
    
    reliability = pd.DataFrame(reliability).set_index(0)

    return reliability.idxmax(axis=1)


# In[17]:


def writeTo_txt(recommend):
    
    file1 = open("recommendations.txt","w")

    for i in range(20):
        if recommend[i] >= 4:
            file1.writelines(recommend.index[i]+"\n")

    file1.close()


# In[18]:


def main(user_id):
    #read in Data from database
    df = readData()

    #generate ratings matrix
    rating_matrix = df.pivot_table(columns='items', index='users', values='rating').fillna('*')

    #get list of ratings of user
    ratings_list = getRatingsList(user_id, rating_matrix)

    #get all users in database and get users index id
    Users = rating_matrix.index.to_list()

    #get all items in database
    Items = rating_matrix.columns.to_list()

    #get list of products 
    unrated_products = getUnratedProducts(ratings_list, rating_matrix)

    userbased_probabilities = getUserbasedProbabilities(df, unrated_products)
    itembased_probabilities = getItembasedProbabilities(df, unrated_products)

    userbased_likelihoods = pd.DataFrame(UserbasedLikelihood(unrated_products, Items, rating_matrix)).drop([1], axis=1).rename(columns = {2:1, 3:2, 4:3,5:4, 6:5})
    itembased_likelihoods = pd.DataFrame(ItembasedLikelihoods(unrated_products, Users, rating_matrix)).drop([1], axis=1).rename(columns = {2:1, 3:2, 4:3,5:4, 6:5})

    user_classifier = pd.concat([userbased_probabilities, userbased_likelihoods],ignore_index=True).groupby(0).prod()
    item_classifier = pd.concat([itembased_probabilities, itembased_likelihoods],ignore_index=True).groupby(0).prod()

    hybrid = combineAlgorithms(unrated_products, user_classifier, item_classifier, rating_matrix, Items)

    s = pd.DataFrame(hybrid.sum(axis=1))

    recommend = getRecommendations(unrated_products, s, hybrid)

    writeTo_txt(recommend)


# In[19]:


if __name__ == "__main__":
    #get user
    user_id = input("User ID: ")
    
    print("\n")
    print("working...")
    main(user_id)
    print("Done! All recommendations are printed to 'Recommendations.txt'")


# In[ ]:





# In[ ]:




