package com.murex;

public class SystemTerminal implements Terminal{
    @Override
    public void print(String input) {
        System.out.print(input);
    }
}
