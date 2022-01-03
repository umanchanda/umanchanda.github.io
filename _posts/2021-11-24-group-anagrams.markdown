---
layout: post
title:  "Leetcode 49: Group Anagrams"
author: Uday
date:   2021-11-24
---

Today I wil be discussing one of the leetcode problems I solved a few days ago. This one is Leetcode 49: Group Anagrams and it's a Medium. You can find it [here](https://leetcode.com/problems/group-anagrams/). The problem is as follows:

```
Given an array of strings strs, group the anagrams together. You can return the answer in any order.
For example, if strs = ["eat","tea","tan","ate","nat","bat"], then we want to return [["bat"],["nat","tan"],["ate","eat","tea"]]
```

This is a little tricky at first but after some thinking, you can solve it using a dictionary/map. 

Before jumping into the problem, it's important to understand how to determine if two strings are anagrams. If two strings are anagrams, then we can re-arrange the letters in the first string to get to the second string. For example, the words `bat` and `tab` are anagrams because the letters `b`, `a`, and `t` can be re-arranged to get `t`, `a`, `b`. Another way of looking at it is by comparing the letters and frequencies in both strings. In this example, we see that both `bat` and `tab` have `1 b`, `1 a`, and `1 t`. We can use this intuition to solve this Group Anagrams.

To solve group anagrams, we will use a dictionary to store the character frequency as the key and the words that match that character frequeucy as the value to the key. In rough terms, the dictionary will look something like this:

```
{
  [1 b, 1 a, 1 t]: ["bat", "tab"]
}
```

Based on the example that Leetcode gave us, our dictionary would look something like this:

```
{
  [1 b, 1 a, 1 t]: ["bat"],
  [1 n, 1 a, 1 t]: ["nat", "tan"],
  [1 a, 1 e, 1 t]: ["ate", "eat", "tea"]
}
```

Once we create this dictionary, we can simply return the values from that dictionary, e.g. something like `return freqs.values()`

The challenge is how to code up the solution. You might initially approach the problem by using the key as a dictionary BUT you cannot do that since dictionary keys CANNOT be dicts or lists. So how are we going to store the character frequencies as the key. For that, we will use tuples. To recap, a tuple is like a list in python but it is immutable, meaning it cannot be modified in any way. 

To create a tuple that will represent our character frequencies, we will initialize a list of 26 elements, each set to 0. For this problem, Leetcode assumes that our strings will be lowercase letters from a-z only. So no uppercase or special characters. As a result, we can limit our frequency list to 26 values only. We also want to ensure that the letter number corresponds to the position in the list. So if we have an `a` in our string, we want it to be counted at the first index, aka the 0th index. And if we have a `z` it should get counted at the last index. 

To do this, we will utilize the `ord()` function in python, which is built-in. `ord` will return the Unicode code of a given character. The Unicode value of `a` is 97, `b` is 98, and `z` is 122. But obviously, we don't have 122 values in our list, we only have 26. So we will shift the unicodes by 97, or the value of `ord('a')`. So now, when we store our characters, they will get placed in the correct order that we want them to be in. 

For example, if our string was `"cab"`, our character list would look like this: `[1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]`. Essentially, we will increment the value at the specificed index if that associated character is in the string. Since `cab` has `1 a`, `1 b`, and `1 c`, the first three indicies will have values of 1 and every other value will be set to 0 by default. If our input string was `"aaabbb"`, the first and second indicies would be 3 and everything would be 0. It is important to keep in mind that we will need to store these character lists as tuples, as mentioned previously. 

Now that we have created our character frequency tuples, we need a way to store the words that correspond to it. To do so, I will use the `defaultdict` class in Python which is in the `collections` module. You import it like: `from collections import defaultdict`. Since the value of the dictionary will be stored as a list, we can initialize our dictionary as `defaultdict(list)`. For every string in the input list, we will calculate it's frequency tuple, and then append it to the word list that corresponds to the frequency tuple like `freqs[f].append(s)` where `freqs` is our dictionary, `f` is the frequency tuple, and `s` is the string we are looking at. 

Our final dictionary will look something like this:

```
{
  (1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0): ['eat', 'tea', 'ate'], 
  (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0): ['tan', 'nat'], 
  (1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0): ['bat']
}
```

From this point, we can return the values in the dictionary, as I previously mentioned. 

**Time complexity**: If there are n words in the input list, and each word has, on average k letters, our time complexity is `O(nk)`

**Space complexity**: Given the same assumptions as before, our space complexity will also be `O(nk)` since that is the total information stored in our dictionary. 

The code for this problem can be found [here](https://github.com/umanchanda/leetcode/blob/main/049-groupAnagrams.py)

I hope to keep doing these blogs where I solve a leetcode problem since I believe this will help me get better at explaining my solution in a proper whiteboarding interview. 