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

import static org.junit.Assert.assertEquals;

public class FizzBuzzTest {
    @Test
    public void fizzBuzz_of_1_is_1() {
        assertEquals("1\n", FizzBuzz.of(1));
    }

    @Test
    public void fizzBuzz_of_2_is_2() {
        assertEquals("2\n", FizzBuzz.of(2));
    }

    @Test
    public void fizzBuzz_of_3_is_fizz() {
        assertEquals("fizz\n", FizzBuzz.of(3));
    }

    @Test
    public void fizzBuzz_of_5_is_buzz() {
        assertEquals("buzz\n", FizzBuzz.of(5));
    }

    @Test
    public void fizzBuzz_of_10_is_buzz() {
        assertEquals("buzz\n", FizzBuzz.of(10));
    }

    @Test
    public void fizzBuzz_of_15_is_fizzbuzz() {
        assertEquals("fizzbuzz\n", FizzBuzz.of(15));
    }

    @Test
    public void fizzBuzz_of_6_is_fizz() {
        assertEquals("fizz\n", FizzBuzz.of(6));
    }

    @Test
    public void full_fizzBuzz_of_2() {
        assertEquals("1\n2\n", FizzBuzz.upTo(2));
    }
}
