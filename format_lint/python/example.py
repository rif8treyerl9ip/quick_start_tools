# ruff: noqa: D100
# I: import order
# import numpy as np
import os
from collections.abc import Iterable

x = np.array(1)


# F821: Undefined name
def undefined_example():
    return undefined_variable


def sum_even_numbers(numbers: Iterable[int]) -> int:  # F821
    """Given an iterable of integers,return the sum of all even numbers in the iterable."""  # noqa: E501
    return sum(num for num in numbers if num % 2 == 0)


# UP007 Use `X | Y` for type annotations
from typing import Union

MyType = Union[str, int]


# W605 [*] Invalid escape sequence: `\e`
# print("このエラーは自動修正できません: \e")


# C408 Unnecessary `list` call (rewrite as a literal)
empty_list = list()


# B006
def func(users=[]):  # リストは空のリストを関数定義で使うべきでない
    """B006 test."""
    return users


# SIM105
try:
    sum_even_numbers()
except:  # E722
    pass


# SIM108
price = 10000
if price > 1000:
    discount = 0.2
else:
    discount = 0.15


# C901 `calculate_value` is too complex (12 > 10)
def calculate_value(x: int, y: int) -> int:
    """Calculate a value based on complex conditions."""
    result = 0

    if x > 0:
        if y > 0:
            result = x + y
        else:
            result = x - y
            if y < -10:
                result *= 2
    else:
        if y < 0:
            result = -x - y
            if x < -5:
                result += 10
            else:
                result += 5
        else:
            result = -x + y
            if x < -3:
                if y > 5:
                    result *= 3
                else:
                    result *= 2
            else:
                result *= 4

    if result > 100:
        if x > 10:
            result = 100
        else:
            result = 90
    elif result < -100:
        if y < -10:
            result = -100
        else:
            result = -90

    return result
