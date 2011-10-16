-module(word_count).
-export([count_words/1]).

count_words([]) -> 1;
count_words([32|Tail]) -> 1 + count_words(Tail);
count_words([Head|Tail]) -> count_words(Tail).
