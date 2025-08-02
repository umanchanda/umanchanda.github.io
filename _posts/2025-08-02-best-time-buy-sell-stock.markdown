---
layout: post
title:  "Leetcode 121: Best Time to Buy and Sell Stock"
author: Uday
date:   2025-08-02
---

The problem can be found [here](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/) and it's a Easy. The problem is as follows:

```
You are given an array prices where prices[i] is the price of a given stock on the ith day. You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock. Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.

Input: prices = [7,1,5,3,6,4]
Output: 5
Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
Note that buying on day 2 and selling on day 1 is not allowed because you must buy before you sell.
```

You might be inclined to solve this problem by finding the difference between minimum and maximum values in the list. But this approach is flawed, since the index of the number matters as well. Using the example provided, if we bought the stock on day 2 we obviously cannot sell on day 1 (unless we have figured out time travel which I don't think is happening any time soon...).

We will need to use the sliding window technique in order to solve this problem. We will keep track of the price on index i and i+1 and check to see if we can make profit, and whether that profit is the most amount of profit we could theoretically make. Let's use the example in the problem to see how this works:

On day 1 the price is 7 and day 2 the price is 1. In this case, we would not engage in any transaction since buying on day 1 and selling on day 2 would incur aprofit of -6. But what about buying on day 1 and selling on day 3? 5-7 means a loss of -2. If we keep checking, we can observe the following:

- Buying on day 1 and selling on day 2 -> 1=7=-6
- Buying on day 1 and selling on day 3 -> 5-7=-2
- Buying on day 1 and selling on day 4 -> 3-7=-4
- Buying on day 1 and selling on day 5 -> 6-7=-1
- Buying on day 1 and selling on day 6 -> 4-7=-3

Those numbers don't look very good!

Let's check the next window, which would be days 2 and 3. Here we see that the prices are now 1 and 5. In this case, we _would_ engage in a transaction, since buying on day 2 and selling on day 3 would incur a profit of 4. But is 4 the most we can make? Only way to know is to check the following days, aka days 4-6:

- Buying on day 2 and selling on day 4 -> 3-1=2
- Buying on day 2 and selling on day 5 -> 6-1=5
- Buying on day 2 and selling on day 6 -> 4-1=3

So the maximum we can make if we were to buy on day 2 is 5, by selling on day 5. 

We have now checked all profit possibilities for buying on day 2. What about if we bought stock on day 3?

- Buying on day 3 and selling on day 4 -> 3-5=-2
- Buying on day 3 and selling on day 5 -> 6-5=1
- Buying on day 3 and selling on day 6 -> 4-5=-1

We can continue this pattern for every single day and we would determine that the max profit would be made by buying on day 2 and selling on day 5 for a profit of 5.

However, we can simplify this approach. We do not need to check every single possibility. In the first scenario, we buy on day 1 at 7 and sell on day 2 at 1 for a profit of -6. Since we know we are going to make a loss on this transaction, we can "skip" ahead to check the next window, which would be buying on day 2 and selling on day 3. Since this does make a profit, we check all possible outcomes as explained earlier. 

From a programmatic perspective, we'd have the left pointer starting at index 0 and right pointer starting at index 1. 
We would then check if the right pointer is greater than the left pointer. If it is, we would calculate the profit and check if it is greater than the current max profit. If it is, we would set the max profit to that value. If it isn't, we would move the left pointer to the right by one index and continue checking.

One thing that confused me when I was doing this problem. We realize that buying on day 1 and selling on day 2 isn't optimal because it results in a loss. But why not check selling day 3 onwards? Well that is because we know that the value on day 2 is our minimum. And when we discover a new minimum, we immediately treat that as our buy value. So we are essentially able to keep track of the minimum value in the list as the left pointer. 

Let's say we added a value of 0 in between days 4 and 5, so that our new list is [7,1,5,3,0,6,4]. In this case, if we bought on day 2 at 1 and sold on day 5 at 0 we'd have a profit of -1. We would set our left pointer to 0 and use that as our "new" minimum. So left pointer is on day 5 (index 4) and right pointer is on day 6 (index 5) and our profit would be 6 (which would also be our max after checking day 7). 


**Time Complexity**: O(n) since we would need to traverse the list once.

**Space Complexity**: O(1) since we are not storing any additional data in a separate list, just need to have two pointers. 

The code to the problem can be found [here](https://github.com/umanchanda/leetcode/blob/main/121-bestTimeToBuyAndSellStock.py) and I hope you enjoyed this writeup. 