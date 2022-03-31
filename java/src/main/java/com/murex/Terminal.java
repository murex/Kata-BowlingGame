package com.murex;

public abstract class Terminal {
    abstract void print(String input);
    final void printLine(String input)
    {
        print(input + "\n");
    }
}
