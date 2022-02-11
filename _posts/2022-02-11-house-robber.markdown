---
layout: post
title:  "Leetcode 198: House Robber"
author: Uday
date:   2022-02-11
---

The problem can be found [here](https://leetcode.com/problems/house-robber/) and it's a Medium. The problem is as follows:

```
Given an integer array nums representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.
Input: nums = [1,2,3,1]
Output: 4
Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
Total amount you can rob = 1 + 3 = 4.
```

When i attempted the problem on my own, I figured I could simply find the sum of all odd indicies and the sum of all even indicies and then compare them. Obviously this logic does not actually work since a robber could theoretically rob house 0 and house 3 if the input array were to look something like `[5,1,1,5]`. He would get 10 by robbing homes 0 and 3 but he would get the same amount if he robbed the evens vs the odds. So this type of logic can be ruled out. 

To approach the correct solution, we can make a decision tree by checking the first two homes. If the robber robs the first home, he must skip the second home and then either robs house 3 or 4. If he robs the second home, he cannot rob house 3 and can only rob house 4. A decision tree could look something like this:

```
    start
    /   \
   1     2
  / \     \
 3  1      1
```

It is best to break up the problem into subproblems. If we start at the first house, we skip the second house, and now our "subproblem" are homes 3 and 4. If we start at the second house, our "subproblem" is now just house 4. Programatically, this could look something like:

```python
max(nums[0] + rob[2:n], max[1:n])
```

We can start at the beginning of the array and compute the most we could rob at each element.
- Starting at at house 0, the most we can rob is `1` since that is the only house.
- Considering houses 0 and 1, we look at the maximum in the array (at that point). The only values we've encountered are 1 and 2. So `2` is our answer.

If we only consider houses 0, 1, and 2, we can either:
- Rob houses 0 and 2 -> `1 + 3 = 4`
- Rob house 1 -> `2`
- Compare which one is greater

When we include all the homes: 
- If we decide to rob house 3, we can either pick the max of house 0 or 1, which we calculated before, and also rob house 3.
- If we don't decide to rob house 3, we can pick the maximum amount from houses 0-2, which we also already calculated before. 
- We can now do a simple comparison:
  - If we pick the first option, the most we could rob is max(house0, house1) + house3 = max(1,2) + 1 = 3
  - If we pick the second option, the most we can rob is 4. 
  - 3 < 4, so 4 is our answer

When we are figuring out how much we can rob at a house, we can look at the previous two results in the array.

```| 1 2 | ~~3~~ | 1 | ```

OR

```| 1 2 3 | ~~1~~```

When we were at house 3, we were essentially comparing the max we could have gotten at house 2 vs the max we could have gotten at house 1. 

Based on this intuition, we don't need a separate array to store the maximums. We can use variables to store house 0 and 1 and a for loop which would start computing at house 2. We set the two variables, which I will call `house0` and `house1` to 0. The for loop would loop through the `nums` array and store the maximum amount at that particular index. Since we start the computing at house 2, the most we can steal is the max of house 0 and n, the value at that index, which in our case is 2 OR house 1. Programatically it would look something like this:

```python
max(n + house0, house1)
```

At this point, our array might look something like this:

```[house0, house1, n]```

As we include more values, the array might start looking like this:

```[house0, house1, n, n+1, n+2, ...]```

We also need to update the values of house0 and house1. 
- The value at house0 is now set to the value at house1
- The value at house1 is now set to the amount we calculated in the previous step. That value should be stored in some kind of temp variable. 

**Time Complexity**: O(n) because we used a single for loop to traverse the entire nums array

**Space Complexity**: O(1) because we are only using variables to store the maximums. A separate array is not required. 

The code to the problem can be found [here](https://github.com/umanchanda/leetcode/blob/main/198-houseRobber.py) and I hope you enjoyed this writeup. 