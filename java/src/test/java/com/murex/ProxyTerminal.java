package com.murex;

import static org.mockito.Mockito.mock;

public class ProxyTerminal extends Terminal {

    public final Terminal mockTerminal = mock(Terminal.class);
    private final SystemTerminal systemTerminal = new SystemTerminal();

    @Override
    public void print(String input) {

        systemTerminal.print(input);
        mockTerminal.print(input);
    }
}
