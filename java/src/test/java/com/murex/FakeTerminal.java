package com.murex;

public class FakeTerminal implements Terminal {
    private String text;

    @Override
    public void print(String text) {
        this.text = text;
    }

    String getPrintedOutput() {
        return this.text;
    }
}
