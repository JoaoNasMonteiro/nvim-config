Telescope (Quick Search)
    Space + f + f : Find files by name across the entire project.
    Space + f + g : Live grep (search for text/words inside all files).
    Space + f + b : List open files (Buffers).
    Space + f + c : Search for files exclusively inside your Neovim config folder.

LSP (These shortcuts only work when you are in a file supported by an LSP)
    g + d : Go to definition (jumps to where the function/variable was created).
    K : Shows documentation or function signature in a floating window (Hover).
    Space + r + n : Rename the variable/function across the entire project.
    Space + c + a : Suggest automatic fixes for an error (Code Action).

Error Handling & Diagnostics (Custom)
    Space + d : Toggle/Focus Diagnostic Float.
    Space + D : Open Error List.
    ]d : Next Error.
    [d : Prev Error.

Clipboard & Text Editing (Custom)
    p (In Visual Mode) : Paste without overwriting clipboard.
    x : Delete character without copying.

Neo-tree
    Space + e : Toggle the sidebar open/closed.

(When cursor is INSIDE the sidebar):
    l : Open the folder or file.
    h : Collapse the folder.
    a : Add a new file (if it ends with /, creates a folder).
    d : Delete the selected file.
    r : Rename the selected file.
    H (uppercase) : Toggle hidden files and Git-ignored files (e.g., .env).

DAP
    Space + b : Toggle a Breakpoint on the current line.
    F5 : Start debugging or continue execution to the next breakpoint.
    F10 : Execute current line and jump to the next (Step Over).
    F11 : Go inside the called function (Step Into).
    F12 : Exit the current function and return to caller (Step Out).

Nvim-Surround
    (In Normal Mode)
    ysiw" : Surround current word with double quotes (e.g., text -> "text").
    cs"' : Change surrounding double quotes to single quotes.
    ds' : Delete surrounding single quotes.

    (In Visual Mode - For selected blocks)
    S (uppercase) + character : Surround the highlighted text.

Gitsigns
    ]c : Jump to the next Git change (hunk) in the file.
    [c : Jump to the previous Git change (hunk).
    Space + h + p : Preview Hunk (shows what was changed in a floating window).
    Space + h + r : Reset Hunk (undoes changes ONLY in that specific block).

Window & Terminal Management (custom)
    :vsp : Vertical split.
    :sp : Horizontal split.
    Ctrl + h/j/k/l : Jump cursor between split windows.
    Ctrl + Arrow Keys : Resize the current window.
    Space + q : Close the window where the cursor is currently located.
    :terminal : Open the integrated terminal in the current window.
    Ctrl + Q : (Inside terminal only) Exit terminal typing mode and return to Normal Mode.

Maintenance Commands
    :Lazy : Open plugin manager (Press uppercase S inside to update everything).
    :Mason : Open the panel to manage LSPs and Debuggers.
