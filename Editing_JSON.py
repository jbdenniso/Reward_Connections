
# coding: utf-8

# In[1]:


import json
import os
files = os.listdir('Downloads')
files_json = [i for i in files if i.endswith('.json')]

files = os.listdir('Desktop/Test_folder')
files_txt = [i for i in files if i.endswith('.txt')]


# In[2]:


for i in range(len(files_json)):
    with open('Downloads/%s'%(files_json[i]),'r')as f:
        data=json.load(f)
        data["IntendedFor"]=[files_txt]
    with open('Downloads/%s'%(files_json[i]),'w')as f:
        json.dump(data,f)

