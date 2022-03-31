package com.murex;

import org.junit.Test;

public class FakeTerminal implements Terminal {
    private String input;

    @Override
    public void print(String input) {
        this.input = input;
    }

    String getPrintedOutput() {
        return this.input;
    }
}
