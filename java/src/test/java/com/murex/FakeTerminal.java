package com.murex;

import org.junit.Test;

public class FakeTerminal implements Terminal {
    @Override
    public void print(String input) {

    }

    String getPrintedOutput() {
        return "";
    }
}
