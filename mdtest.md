# Markdown & LaTeX Rendering Stress Test

## 1. Text Formatting & UI Elements
This paragraph tests basic formatting. We have **bold text**, *italic text*, ***bold and italic***, and ~~strikethrough text~~.

We can also test `inline code` to see if the plugin gives it a nice background color, like when declaring `volatile int sensor_val;`.

## 2. Lists and Checkboxes
* Unordered list item 1
* Unordered list item 2
1. Ordered list item 1
2. Ordered list item 2
- [x] Completed task (Should render as a filled/green box)
- [ ] Pending task (Should render as an empty box)
- aaa
- aa

## 3. Blockquotes
> "C makes it easy to shoot yourself in the foot; C++ makes it harder, but when you do it blows your whole leg off."
> — Bjarne Stroustrup

## 4. Code Blocks
```c
#include <stdio.h>

// This block should have a distinct background and a language icon
int main() {
    printf("Testing Treesitter injection inside Markdown!\n");
    return 0;
}

```

## 5. Table Rendering

| Hex Address | Register Name | Read/Write | Description |
| --- | --- | --- | --- |
| 0x40021000 | RCC_CR | R/W | Clock control register |
| 0x40021004 | RCC_PLLCFGR | R/W | PLL configuration register |
| 0x40021008 | RCC_CFGR | R/W | Clock configuration register |

## 6. LaTeX Mathematics

### Inline Math

The plugin should cleanly render the area of a circle as $A=\pi r^2$ without breaking the line height. It should also handle Euler's identity: $e^{i\pi}+1=0$.

### Display Math (Block)

Here is the Fourier Transform. The integrals and fractions should be converted into readable Unicode equivalents:


$$f(x)=\int_{-\infty}^{\infty}\hat{f}(\xi)\,e^{2\pi i\xi x}\,d\xi$$

And Maxwell's equations to test stacked Greek letters and partial derivatives:

$$\nabla\cdot\mathbf{E}=\frac{\rho}{\varepsilon_0}$$

$$\nabla\times\mathbf{E}=-\frac{\partial\mathbf{B}}{\partial t}$$

### How to Evaluate the Test

Once you paste this into Neovim, check for these specific success indicators:
* **The Headings:** The `#` symbols should disappear, replaced by clean icons (like `󰲡`).
* **The Table:** The raw `|` pipes should instantly transform into the explicit box-drawing characters we configured earlier.
* **The Math:** The `$` delimiters should vanish, and you should see actual $\pi$, $\nabla$, and $\int$ symbols directly in the editor.

If you place your cursor over the table or the math and enter Insert mode (`i`), the plugin will temporarily reveal the raw Markdown (`|` and `$`) so you can type, and it will re-render them the second you hit `Esc`.

Did the LaTeX equations render into readable symbols, or are they still showing the raw text with the `$` signs?

