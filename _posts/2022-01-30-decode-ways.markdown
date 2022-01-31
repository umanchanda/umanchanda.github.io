---
layout: post
title:  "Leetcode 91: Decode Ways"
author: Uday
date:   2022-01-30
---

The problem can be found [here](https://leetcode.com/problems/decode-ways/) and it's a Medium. The problem is as follows:

```
A message containing letters from A-Z can be encoded into numbers using the following mapping:

'A' -> "1"
'B' -> "2"
...
'Z' -> "26"

Input: s = "12"
Output: 2
Explanation: "12" could be decoded as "AB" (1 2) or "L" (12).
```

When approaching the problem, it's important to break up the problem into smaller sub-problems, which is why it's a classic Dynamic Programming problem. In this case, we will break up the string into smaller substrings, which can correspond to a specific number. Let's use the given example where `s=12`. We analyze the first character, `1`. We know that `1` corresponds to `A` in the alphabet. However, we also know that `1` could also be the start of a two digit number from `10-19`. Same goes for `2` which could correspond to the start of a two digit number from `20-26`. If a number is from `3-9` we know that it can only represent a single digit and therefore a single character. But for 1 and 2, we need to check the next digit before concluding what the letter might be. 

We can also represent this as a decision tree, where we start at the beginning and draw arrows depending on what "decision" to take next. Here is a rudimentary example of using `s=12`:

```
    "12"
    /  \
   "1"  "12"
  /
"2"
```

We know that the first digit `1` coresponds to `"A"` and when we next the next digit `2` that corresponds to the letter `"B"`. However, as previously mentioned, since we have a 1 and 2, we can correspond the 12 back to L. So in this scenario, there are two ways to decode this string. (i know the answer was posted in the problem but i wanted to go through it).

The way I approached the problem was to create a list which holds the possible number of "ways" at each character in the string. If the string has length 0 there is only one way to decode it. If a string has length of 1 there is only 1 way to decode it, unless that character is a 0, in which there are 0 ways to decode it. For strings where the length is 2 or more, we loop through the string, and check the digit before it and two digits before it. If we check the two digits before it and those two digits correspond to a number between 10 and 26 we have found a character between J and Z. If we check the digit before it, we can correspond it to a letter between A and I. 

Keep in mind that we do not need to print out all possible ways, just the total number of ways. So if the digit before it is greater than 1 we know that the total number of ways at that index is one more than the index before it. If our input string was `"789"`, there is one way to decode the first character, one more way to decode the string at the second character (2), and one more way to decode the string at the third character (3). So our final answer is 3. 

Let's say our input string was `"121"`. There is one way to decode the string at the first index, but when we hit the second index, there are two ways to decode it because we can either have 1 and 2 separately or 12. At the third index, there are also two more ways to decode it because we can treat the 2 and 1 separately or 21 as a single character. So we would go from 1 to 3 to 5, which is our final answer. 

After traversing the string, you would return the value at the final index. This means you would initialize a list with 0 times the number of characters in the input string. For example:

```python
dp = [0] * (len(s) + 1)
return dp[len(s)]
```

could be a way to represent that with code. 

**Time Complexity**: O(n) because you traverse the input string once. 

**Space Complexity**: O(n) because you initialize a separate list with the same number of elements as the number of characters in the input string.

The code to the problem can be found [here](https://github.com/umanchanda/leetcode/blob/main/091-decodeWays.py) and I hope you enjoyed this writeup. 