import sys
import textwrap
from collections import defaultdict


class Node:
    def __init__(self, label):
        self.children = []
        self.label = label

    def add(self, child):
        self.children.append(child)

    def __str__(self):
        def f():
            if self.children:
                print(level, self.label)
                yield f'label: {self.label}'
                for child in self.children:
                    yield textwrap.indent(str(child), '  ')
            else:
                yield f'leaf: {self.label}'

        return '\n'.join(f())

    def latexify(self, level=0):
        if self.children:  # Container
            assert level <= 2
            if level == 1:
                yield f'\\part{{{self.label}}}'
            elif level == 2:
                yield f'\\chapter{{{self.label}}}'
            for child in self.children:
                yield from child.latexify(level + 1)
        else:  # Leaf
            start = self.label.rfind('(')
            file = self.label[start+1:-1]
            file = file.replace('md', 'tex')
            yield f'\\input{{e-maxx-eng/src/{file}}}'


def indent_level(s):
    return (len(s) - len(s.lstrip(' '))) // 4


root = Node('<root>')
with open(sys.argv[1]) as f:
    stack = [root]
    for s in f:
        level = indent_level(s)
        s = s.strip().removeprefix('- ')

        while level < len(stack) - 1:
            stack.pop()
        cur = stack[-1]

        child = Node(s)
        cur.add(child)
        stack.append(child)

assert root.children.pop(0).label == 'Home'

print('\n'.join(root.latexify()))
