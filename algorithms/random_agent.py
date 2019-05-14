#!/usr/bin/env python
# coding: utf-8

# In[15]:


from vizdoom import *
import random
import time


# In[16]:



# In[17]:


game = DoomGame()
game.load_config("scenarios/basic.cfg")
game.set_window_visible(False) # We have to set this while running in a docker env. https://github.com/mwydmuch/ViZDoom/issues/200
game.init()


# In[18]:


shoot = [0, 0, 1]
left = [1, 0, 0]
right = [0, 1, 0]
actions = [shoot, left, right]


# In[20]:


episodes = 10
for i in range(episodes):
    game.new_episode()
    while not game.is_episode_finished():
        state = game.get_state()
        img = state.screen_buffer
        misc = state.game_variables
        reward = game.make_action(random.choice(actions))
        #print(f"\treward: {reward}")
        #time.sleep(0.02)
    print(f"Result: {game.get_total_reward()}")
    #time.sleep(2)


# In[ ]:




