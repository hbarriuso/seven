-module(shopping_cart).
-export([total_price/1]).

total_price(Cart) -> [{Item, Quantity * Price} || {Item, Quantity, Price} <- Cart].
