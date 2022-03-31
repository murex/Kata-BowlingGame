package com.murex;

public class SystemTerminal extends Terminal{
    @Override
    public void print(String input) {
        System.out.print(input);
    }
}
