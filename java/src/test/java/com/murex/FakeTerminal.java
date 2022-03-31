package com.murex;

public class FakeTerminal extends Terminal {
    private String text = "";

    @Override
    public void print(String text) {
        this.text += text;
    }

    String getPrintedText() {
        return this.text;
    }
}
