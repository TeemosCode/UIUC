"""
Assignment 3 on Test-Driven Design
590PR - J. Weible

The following function definitions are empty, but they all contain
real unit tests (in the form of Doctests) that you can run as
demonstrated in class during Week 4.

Your task is to use the descriptive documentation and example behaviors
shown in Doctests to understand what the functions are supposed to do
and then write the code for the functions to work properly so all the
existing tests succeed.

This is a simple example of using the Test-Driven Design (TDD) process.

TIP: You should be able to use some of these custom functions to help
write the code for others. Doing so is practicing code re-use.
"""


def alternate_case(s: str, upper_first=True) -> str:
    """Given an arbitrary string, convert every odd character to
    upper case and even to lower-case (or vice-versa)

    :param s: a string to start with
    :param upper_first: defaults to uppers first, set False for opposite
    :return: the altered string

    >>> alternate_case('abcdefg')
    'AbCdEfG'
    >>> alternate_case('abcdefg', upper_first=False)
    'aBcDeFg'
    >>> alternate_case('The Three-Body Problem, by Cixin Liu')
    'ThE ThReE-BoDy pRoBlEm, By cIxIn lIu'
    """
    string_builder = ''

    i = 0 if upper_first else 1
    for index in range(len(s)):
        if index % 2 == i:
            string_builder += s[index].upper()
        else:
            string_builder += s[index].lower()

    return string_builder


def get_every_number(mixed_list: list) -> list:
    """Create a new list from a mixed-type list, keeping only the number type items.
    In other words, it ignores strings, tuples, sublists, dictionaries, etc.

    :param mixed_list: a 1-dimensional list containing various types of data
    :return: a new list containing only the items that are number types

    >>> get_every_number(['abc', 42, 3.14159, 2 * 4, '9'])
    [42, 3.14159, 8]
    >>> get_every_number([75, 101010101, 0xC0ffee, 'java'])
    [75, 101010101, 12648430]
    """
    return [num for num in mixed_list if type(num) == int or type(num) == float ]


def back_words(s: str) -> str:
    """Rearrange a string so that every word gets spelled backwards but the
    sequence of words and any punctuation stays the same.

    :param s: any string
    :return: a string with words in the same order but each word spelled backwards.

    >>> back_words('even yellow apples are not bananas.')
    'neve wolley selppa era ton sananab.'
    >>> back_words('to be or not to be, that is the question.')
    'ot eb ro ton ot eb, taht si eht noitseuq.'
    """
    def reverse_word(word: str) -> str:
        string_builder = ''
        ending_char = ''
        for index in range(len(word) - 1, -1, -1):
            if ord(word[index]) < 65 or ord(word[index]) > 122:
                ending_char = word[index]
                continue
            string_builder += word[index]
        return string_builder + ending_char

    ls = s.split(" ")
    for i in range(len(ls)):
        ls[i] = reverse_word(ls[i])
    return ' '.join(ls)






def flatten_list(nested_list: list) -> list:
    """Given a list contains other lists nested to any depth,
    compute a new 1-dimensional list containing all the original non-list
    values in the same order. Non-list collections are kept as-is, not flattened,
    even if they contain other lists.

    :param nested_list: A list that contains other lists, to any depth.
    :return: a 1-dimensional list with all the original non-list values in the same order.

    >>> flatten_list([[[[[1, 2], 3]], 4, 5], 6])
    [1, 2, 3, 4, 5, 6]
    >>> flatten_list(['abc', 2, ['x', 'y'], ['a', 'b'], [[[[[[[[[[['z']]]]]]]]]]]])
    ['abc', 2, 'x', 'y', 'a', 'b', 'z']
    >>> flatten_list([1, 2, (3, [4, 5]), ['cat', 'in', 'the', 'hat']])
    [1, 2, (3, [4, 5]), 'cat', 'in', 'the', 'hat']
    >>> flatten_list(['this list', 'is', 'not', 'nested'])
    Traceback (most recent call last):
    ...
    ValueError: nested_list parameter was already 1-dimensional.
    """
    pass


def sum_list_numbers(x: list) -> float:
    """Given any list of mixed data types, possibly nested with other lists,
    compute the arithmetic sum of all the numeric values contained in it.
    Supports integers, floats, decimals, and lists thereof. Ignores values 
    contained in non-list collections.

    :param x: a list of mixed data types, possibly nested with other lists.
    :return: the sum of all numeric values contained in list x.

    >>> sum_list_numbers([5, 2, 3])
    10.0
    >>> sum_list_numbers([[[2, 5], 4]])
    11.0
    >>> sum_list_numbers([['number 5', [[25.2]]], 0.9, 'x', [4]])
    30.1
    >>> sum_list_numbers([34, 2, (5, 1)])
    36.0
    >>> sum_list_numbers([{45: 5, 100: -200}])
    0.0
    """
    sum_ans = 0
    while x:
        element = x.pop(0)
        if type(element) != list and type(element) != int and type(element) != float:
            continue
        elif type(element) == list:
            x.extend(element)
            continue
        sum_ans += element

    return float(sum_ans)
