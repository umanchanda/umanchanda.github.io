---
layout: post
title:  "Leetcode 3: Longest Substring Without Repeating Characters"
author: Uday
date:   2021-11-25
---

This is another leetcode problem I solved a while back but wanted to blog about how I solved it. The problem can be found [here](https://leetcode.com/problems/longest-substring-without-repeating-characters/) and it's a Medium. The problem is as follows:

```
Given a string s, find the length of the longest substring without repeating characters.
Input: s = "abcabcbb"
Output: 3
Explanation: The answer is "abc", with the length of 3.
```

The brute force approach to solving this problem would involve a nested for-loop by checking every single possible combination of characters. If two adjacent characters are the same, it means that the given substring we are looking at contains a repeating character pattern, for which we would not include. The worst case time complexity would be `O(n^2)` since we have the nested for-loop structure. This approach can be dramatically improved to `O(n)` by utilizing a common algorithm for solving many array and string questions: the Sliding Window. 

For this problem, we will utilize a left and right pointer and our window will be the range from left to right. We also need some kind of data structure to store unique elements. The best one would be a set. This set will store the characters in our sliding window and will add or remove depending on if we have already seen the current string. 

To solve the problem I will use the example that Leetcode gives us. We will initialize our left and right pointers to 0, which is the first character in the string, `a`. Since our set is empty, we can add it there. Since we have not found any duplicates yet, we will only slide the right pointer by incrementing by one. The next character is `b`. Since we don't have a `b` in our set, we will add it to our set, and then slide the right pointer again by one. The next character is `c`. Since we haven't seeen a `c` in our set just yet, we slide right again. 

Now, the next character is an `a`. However, we already have an `a` in our set. So we need to remove that first `a` from our set, which is esesntialy the left pointer. After we remove the `a`, we slide BOTH the left and right pointers. Our window (set) now contains `b`, `c`, and `a`. The next character is `b`, which already exists in our set. So we do the same thing for the previous character. 

If you notice, we keep adding the left and right characters to our string and increment the right pointer by 1. However, if the character at the right pointer already exists in our set, we will remove the character at the left pointer and increment our left pointer by 1. 

Another important thing to mention is that we need a variable to store the length of the existing substring and compare it to the length of the window, which can be calculated by doing `r - l`. Once our right pointer hits the end of the string, we can stop iterating through the string. 

**Time Complexity**: We are guaranteed to do a single traversal of the string. So our time complexity is `O(n)`.

**Space Complexity**: At worst, we will need to store every single character in our set if every single character in the string is unique. So the space complexity is `O(n)`. 

The code to the problem can be found [here](https://github.com/umanchanda/leetcode/blob/main/003-longestSubstringWithoutRepeatingCharacters.py) and I hope you enjoyed this writeup. 