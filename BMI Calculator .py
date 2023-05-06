#!/usr/bin/env python
# coding: utf-8

# In[ ]:





# In[22]:


name = input("Enter your name: ")

weight =float(input("Enter your weight in kilograms: "))

height =float(input("Enter your height in meters: "))

BMI = (weight) / (height * height) 
print(BMI)

if BMI>0:
    if(BMI<18.5):
        print(name +", you are underweight.You need to eat more and do some exercises")
    elif (BMI<=24.9):
        print(name +", you have normal weight. Love yourself:)")
    elif (BMI<29.9):
        print(name +", you are overweight. You need to exercise more")
    elif (BMI<34.9):
        print(name +", you are obese. You need to go more outside and pay attention on your food")
    elif (BMI<39.9):
        print(name +", you are severely obese.You need to start eat a healthy food and do some exercises")
    else:
        print(name +", you are morbidly obese.")
else: print("Enter valid input")     
    


# In[7]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:


#BMI = (weight in pounds x 703) / (height in inches x height in inches)


# In[ ]:


Under 18.5	Underweight	Minimal
18.5 - 24.9	Normal Weight	Minimal
25 - 29.9	Overweight	Increased
30 - 34.9	Obese	High
35 - 39.9	Severely Obese	Very High
40 and over	Morbidly Obese	Extremely High


# In[19]:


if BMI>0:
    if(BMI<18.5):
        print(name +", you are underweight.")
    elif (BMI<=24.9):
        print(name +", you are normal weight.")
    elif (BMI<29.9):
        print(name +", you are overweight. You need to exercise more and stop sitting and writing so many python tutorials.")
    elif (BMI<34.9):
        print(name +", you are obese.")
    elif (BMI<39.9):
        print(name +", you are severely obese.")
    else:
        print(name +", you are morbidly obese.")


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




