/*
Copyright (c) 2021 Murex

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

package com.murex;

import org.junit.Test;
import org.mockito.InOrder;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static org.mockito.Mockito.*;

public class FizzBuzzTest {
    @Test
    public void fizzBuzz_of_1_is_1() {
        assertEquals("1\n", FizzBuzz.of(1, "\n"));
    }

    @Test
    public void fizzBuzz_of_2_is_2() {
        assertEquals("2\n", FizzBuzz.of(2, "\n"));
    }

    @Test
    public void fizzBuzz_of_3_is_fizz() {
        assertEquals("fizz\n", FizzBuzz.of(3, "\n"));
    }

    @Test
    public void fizzBuzz_of_5_is_buzz() {
        assertEquals("buzz\n", FizzBuzz.of(5, "\n"));
    }

    @Test
    public void fizzBuzz_of_10_is_buzz() {
        assertEquals("buzz\n", FizzBuzz.of(10, "\n"));
    }

    @Test
    public void fizzBuzz_of_15_is_fizzbuzz() {
        assertEquals("fizzbuzz\n", FizzBuzz.of(15, "\n"));
    }

    @Test
    public void fizzBuzz_of_30_is_fizzbuzz() {
        assertEquals("fizzbuzz\n", FizzBuzz.of(30, "\n"));
    }

    @Test
    public void fizzBuzz_of_6_is_fizz() {
        assertEquals("fizz\n", FizzBuzz.of(6, "\n"));
    }

    @Test
    public void full_fizzBuzz_of_2() {
        FakeTerminal terminal = new FakeTerminal();
        FizzBuzz.upTo(2, terminal);
        assertEquals("1\n2\n", terminal.getPrintedText());
    }

    @Test
    public void end_to_end_fizzbuzz() {
        FakeTerminal fakeTerminal = new FakeTerminal();
        FizzBuzz.run(fakeTerminal, 100);
        assertTrue(fakeTerminal.getPrintedText().startsWith("1\n2\nfizz\n"));
        assertTrue(fakeTerminal.getPrintedText().endsWith("buzz\n"));
    }

    @Test
    public void full_fizzBuzz_should_print_results() {
        Terminal mockTerminal = mock(Terminal.class);

        FizzBuzz.upTo(2, mockTerminal);

        InOrder inOrder = inOrder(mockTerminal);

        inOrder.verify(mockTerminal).print("1\n");
        inOrder.verify(mockTerminal).print("2\n");

        verify(mockTerminal, times(2));
    }

    @Test
    public void full_fizzBuzz_should_print_results_proxy() {
        ProxyTerminal proxyTerminal = new ProxyTerminal();

        FizzBuzz.upTo(2, proxyTerminal);

        verify(proxyTerminal.mockTerminal).print("1\n");
        verify(proxyTerminal.mockTerminal).print("2\n");

        //verify(proxyTerminal.mockTerminal, times(2));
    }

}
