import numpy as np         #for logarithms and creating linspace arrays
import random              #for uniform random variables

from matplotlib import pyplot as plt  #for plotting!
from tqdm import tqdm                 #for loading bar

#%%

# A homogeneous Poisson point process with intensity 1 in the interval [1,10]

num_events_list = []
inter_event_times = []
its = 10000

for i in range(its):
    _lambda = 1
    event_times = []
    time = 1
    num_events = []
    
    while time < 10: 
        random_num = random.random()
    
        inter_event_time = -np.log(1 - random_num)/_lambda
        inter_event_times.append(inter_event_time)
        time = time + inter_event_time
        event_times.append(time)
        num_events.append(0)
        
    event_times = event_times[:-1]
    num_events = num_events[:-1]
    num_events_list.append(len(num_events))
    
av_inter_event_times = np.array(inter_event_times).mean()
av_num_events = np.array(num_events_list).mean()
    
plt.figure()

plt.scatter(event_times,num_events, marker = 'x', color = 'k', alpha = 0.8, label = 'Poisson Point Process, $\lambda$ = 1')
plt.grid(color = 'k', linewidth = 0.5, alpha = 0.3, linestyle = '--')
plt.legend()
plt.show()

#%%

# The first 10 points of a homogeneous Poisson point process with intensity 1 on [0,∞)

num_events_list = []
inter_event_times = []
its = 100

for j in range(its):
    _lambda = 1
    event_times = []
    time = 0
    num_events = []
    
    for i in range(10): 
        random_num = random.random()
        inter_event_time = -np.log(1 - random_num)/_lambda
        inter_event_times.append(inter_event_time)
        time = time + inter_event_time
        event_times.append(time)
        num_events.append(0)
        
    num_events_list.append(len(num_events))
    
av_inter_event_times = np.array(inter_event_times).mean()
av_num_events = np.array(num_events_list).mean()
    
plt.figure()
plt.scatter(event_times,num_events, marker = 'x', color = 'k', alpha = 0.8, label = 'Poisson Point Process, $\lambda$ = 1')
plt.grid(color = 'k', linewidth = 0.5, alpha = 0.3, linestyle = '--')
plt.legend()
plt.show()

#%%

# A Poisson point process on [1,∞) whose intensity measure has density x^−α , α > 1 with respect
# to the Lebesgue measure.

alpha = 1.1

def intensity_measure(x,alpha): 
    
    return x**(-alpha)


lambda_0 = 1

num_events_list = []
inter_event_times = []
its = 1

for j in tqdm(range(its)):
    _lambda = lambda_0
    event_times = []
    time = 1
    num_events = []
    
    while time < 10000: 
        random_num = random.random()
    
        inter_event_time = -np.log(1 - random_num)/_lambda
        inter_event_times.append(inter_event_time)
        time = time + inter_event_time
        event_times.append(time)
        
        
    event_times = event_times[:-1]
    num_events = num_events[:-1]
    
    event_times_post_thinning = []
    for i in range(len(event_times)):
        retention_prob = intensity_measure(event_times[i], alpha)/lambda_0
        random_num2 = random.random()
        
        if random_num2 <= retention_prob:
            event_times_post_thinning.append(event_times[i])
            num_events.append(0)
            
    event_times = event_times_post_thinning
    num_events_list.append(len(num_events))
    
av_inter_event_times = np.array(inter_event_times).mean()
av_num_events = np.array(num_events_list).mean()
    

if len(event_times) > 0:
    x = np.linspace(np.array(event_times).min(),np.array(event_times).max(),50)
    y = intensity_measure(x,alpha)
    
    
    plt.figure()
    plt.scatter(event_times,num_events, marker = 'x', color = 'k', alpha = 0.8, label = f'Poisson Point Process, $\lambda(x)$ = x^-({alpha})')
    plt.plot(x,y, color = 'r', alpha = 0.6, linestyle = '--', label = f'$\lambda(x)$ = x^-({alpha})')
    plt.grid(color = 'k', linewidth = 0.5, alpha = 0.3, linestyle = '--')
    plt.legend()
    plt.show()
else:
    print('NO POISSON POINT OCCURANCES IN THIS ITERATION, TRY AGAIN!')


#%%

# A Poisson point process on [0,2] whose intensity measure has density 1−(1−x)^2 
# with respect to the Lebesgue measure.


def intensity_measure(x): 
    
    return 1 - (1-x)**2


lambda_0 = 1

num_events_list = []
inter_event_times = []
its = 1

for j in range(its):
    _lambda = lambda_0
    event_times = []
    time = 0
    num_events = []
    
    while time < 2: 
        random_num = random.random()
    
        inter_event_time = -np.log(1 - random_num)/_lambda
        inter_event_times.append(inter_event_time)
        time = time + inter_event_time
        event_times.append(time)
        
        
    event_times = event_times[:-1]
    num_events = num_events[:-1]
    
    event_times_post_thinning = []
    for i in range(len(event_times)):
        retention_prob = intensity_measure(event_times[i])/lambda_0
        random_num2 = random.random()
        
        if random_num2 <= retention_prob:
            event_times_post_thinning.append(event_times[i])
            num_events.append(0)
            
    event_times = event_times_post_thinning
    num_events_list.append(len(num_events))
    
av_inter_event_times = np.array(inter_event_times).mean()
av_num_events = np.array(num_events_list).mean()
    
if len(event_times) > 0:
    x = np.linspace(np.array(event_times).min(),np.array(event_times).max(),50)
    y = intensity_measure(x)
    
    
    plt.figure()
    plt.scatter(event_times,num_events, marker = 'x', color = 'k', alpha = 0.8, label = f'Poisson Point Process, $\lambda(x)$ = 1 - (1 - x)^2')
    plt.plot(x,y, color = 'r', alpha = 0.6, linestyle = '--', label = f'$\lambda(x)$ = 1 - (1 - x)^2')
    plt.grid(color = 'k', linewidth = 0.5, alpha = 0.3, linestyle = '--')
    plt.legend()
    plt.show()
else:
    print('NO POISSON POINT OCCURANCES IN THIS ITERATION, TRY AGAIN!')

