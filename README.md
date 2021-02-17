## Vim Setup that Works Like a Charm

This repo contains the vim setup that I personally use. If you follow it step by step, you should be able to configure your built-in vim form scratch without any headache. These setups only works if you are using Ubuntu Linux. It is *not* needed to install vim from source.

You should use `vim-gnome` instead of the default `vim` that came with Ubuntu because by using `vim-gnome` you can copy from and to clipboard across multiple vim instances. There are other good things about `vim-gnome`. Just install it:

```
sudo apt install vim-gnome
```

You can launch vim by either typing `vi` or `vim` in the terminal. They should be pointing to the exact same version of vim. The following steps introduce how to properly setup your vim.

This repository contains two vim config files:

1. `.vimrc`, which is the vim config file that you use when you are running vim in a terminal.
2. `.ideavimrc`, which is the vim vonfig file when you are running vim in a JetBrains IDE like PyCharm and CLion.

## Step by step guide

### Installing dependencies

Ctags enable you to navigate in your code. This is necessary for `vim-gutentags` to work 

```
sudo apt-get install ctags
```

Install Clang format for C++
```
sudo apt install clang-format
```

Install autopep8 for Python formatter
```
sudo apt install python-autopep8
```


### Clone the repository

The following instruction assumes that you have cloned the repository in `~/utils`.

### Set symbolic link to vim config files

```
ln -s ~/utils/VimCharm/.vimrc ~/.vimrc
```

In case the symbolic link exists already, force update it by passing in argument `-f`:

```
ln -sf ~/utils/VimCharm/.vimrc ~/.vimrc
```

If you are also using vim in CLion and PyCharm, you should do the same step to link `ideavimrc`:

```
ln -s ~/utils/VimCharm/.ideavimrc .ideavimrc

```

### Install package manger

Use [vim-plug](https://github.com/junegunn/vim-plug) as your vim package manager. Simply do:

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Now, open your `.vimrc` file by typing `vim ~/.vimrc`.

Inside vim editor, do `:source ~/.vimrc`, which enables the system to load the brand new vim config file.

Now, run `:PlugInstall` (also inside the vim editor). This will install all the packages managed by `vim-plug`.

### Some setup on your computer

There are some setup you need to perform on your computer to have all the packages working correctly.

There is a good machine learning based code auto completion. You need `cquery` for C++ completion.

See https://github.com/cquery-project/cquery/wiki/Building-cquery

```
git clone --recursive https://github.com/cquery-project/cquery.git
cd cquery
git submodule update --init
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=release -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
cmake --build .
cmake --build . --target install
```

### Done

That's should be it. Enjoy vim!

## Useful vim commands

This list probably doesn't include the very basics (like using `h`, `j`, `k`, `l` to navigates)

### Navigation

`Ctrl-f` - Move forward a page, `Ctrl-b` - Move backward a page.

`w` - Forward to the beginning of next word, `W` - Forward to the beginning of the next WORD.

`b` - Backward to the next beginning of a word, `B` - Backward to the next beginning of a WORD.

`e` - Forward to the next end of word, `E` - Forward to the next end of WORD.

`0` - Move to the beginning of the line (including blank space).

`^` - First non blank character of the line.

`$` - Go to end of the line.

`gg` - Go to top of the file, `G` - Go to end of the file.

`15G`,`15gg`, or `:15` - Go to line 15.

A `WORD` is always delimited by whitespace.

A `word` is delimited by non-keyword characters, which are configurable. Whitespace characters aren't keywords, and usually other characters (like ()[],-) aren't, neither. Therefore, a word usually is smaller than a WORD; a "word-navigation" is more fine-grained than a "WORD-NAVIGATOR".

`Ctrl-o` to jump back to where you were

`Ctrl-i` to jump back and forth

`zz` centers the view

### Delete

`x` - Delete under current cursor, `X` - Delete before current cursor.

`d/whatever` - Delete until word whatever.

`dd` or `D` - Delete (cut) one single line

`3dd` - Delete 3 lines.

`3dw` - Delete 3 words, `3dW` - Delete 3 WORDs.

`3cw` - Delete 3 words and enter insert mode, `3cW` - Delete 3 WORDs and enter insert mode.

`p` to paste after cursor, `P` to paste before cursor

`xp` - Super fast way to swap two letters (`x` cuts the letter, and `p` pastes after current letter, effectively swap two letters).

### Yank and put

`yiw` to yank a word, then `viwp` to repalce another word with yanked word. Same priciple applies to other commands. For example, `yi(` to yank all arguments in a function, then `vi(p` to replace another function argument with the yanked argument.

`y` to yank, `yy` to yank current line, `7yy` to yank 7 lines. 

`y/whatever` to yank until word whatever.

`yiw`: yank a word, excluding surrounding whitespace, `[n]yiw` to yand multiple words, `yi(` to yank everything inside the parenthesis.

`p` to paste after cursor, `P` paste before cursor

`:reg` to check all registers. `:reg 3z` to check register 3 and z. Note there are both 0-9 numbered registers and a-z named registers.

`"0p` to paste most recent yanked text. `"1p` to paste most recent deleted text

`"_dd` to delete a line and put it in black hold register. This is useful when you've yanked some thing and want to replace some text but don't want `y` operation to overwrite whatever you've yanked.

Register `""` holds text from `d` `c` `s` `x` and `y` opearations. `"0"` holds the most recent yanked text. `"1"` holds the most recent deleted text. Numbered registers shift with each `d` or `c`.

`"ayi(` - Yank everything insides parenthesis into 'a' register

`"Ayy` - Append current line to register `a`. Using uppercase of register appends to current register. Using lowercase of register name replaces the information stored in the register.

`"ap` - Paste whatever in 'a' register

`"kp` to paste stuff in register elsewhere

`"+p` to paste from system clipboard on Linux

### Search, find and replace

`[n]f<o>` - Forward until (nth) (o)  (Inclusive, until and include). Example, `df<letter>` delete until `<letter>` and include `<letter>` i.e. `<letter>` being deleted as well. Example, `cf<letter>` delete until `<letter>` and include `<letter>` i.e. `<letter>` being deleted as well, and switch to INSERT MODE. 

`[n]F<o>` - Backward until (nth) (o) (Inclusive, until and include)

`[n]t<o>` - Forward until (nth) (o)  (Exclusive, until but not include)

`[n]T<o>` - Backward until (nth) (o) (Exclusive, until but not include)

`/` to search, press `enter`, then `n` to search next, `N` to search previous

`:%s/foo/bar/g` change all `foo` to `bar`, change `g` to `gc` to ask for comfirmation before change. Note that "%" means entire file range/

`.,+2s/foo/bar/g` if you would like to change each `foo` to `bar` for current line (`.`) and the two next lines (`+2`)

### Text objects

`ci{` change inside `{}`

`ci[` change inside `[]`

`ci(` change inside `()`

`ci<` change inside `<>`

Similar concept applies to `yi(`, `di(`... You can also use the close bracket such as `di]` or `da]` if you want.

If you replace `i` with `a` (think of `a` as "around" and `i` as inside), then the change is inclusive. For example, `da[` deletes everything inside bracket, INCLUDING the brackets themselves. For example, `apple [whatever] pear` becomes `apple  pear`.

If you are working with `xml` sytle document, you can make changes to stuff inside a tag. For example, use `dit` to delete  everything inside `<p>whatever</p>` so it becomes `<p></p>`

### Macros

`qa` to record macro to register a. Hit `q` when you've finished recording.

`@a` to replay macro in register a. `@@` to replay the most recent recorded macro.

`5@a` to replay macro in register a 5 times.

`qA` to append to register a. When you've finished appending, type `q`.

### Miscellaneous

`Ctrl-[` to escapt. Same as `ESC`. Note: To get the special `^` in `~/.vimrc`, use `Ctrl-v` (you can't use literal caret sign). For example, if you want to specify escape in your `~/.vimrc`, you need to use `Ctrl-v` to get the `^`. For specific example on how to set up a customized macro, see the `.vimrc` file.

If you git checkout or git pull, use `:e` to update the buffer of the view to get the newest info

`u` to undo, `Ctrl-r` to redo

`v` to visual select, `V` to visual select lines, `ctrl-v` for more specific selection.

`*` to search the current word (bounded, exact match), `g*` to search the current word (unbounded, partial match)

`Ctrl-w` then `v` to split vertically line

`Ctrl-w` then `s` to split horizonally line

`Ctrl-w` then `arrow key` to jump bt windows

`~` - Toggle case of character under cursor

`Ctrl-]` to jump to function definition when cursor is on function

`.` repeat last command

`]m` jump to next method (i.e. jump to next curly braces)

`[m` jump to previous method

`s` - Delete character under cursor and enter insert mode

`S` or `cc` - Delete line and begin insert at beginning of same line.

`I` - Enter insert mode at first non-blank character.

`R` - Replace mode.

`i` - Enter insert mode _before_ cursor. `a` - Enter insert mode _after_ cursor

`A` - Enter insert mode at the end of the line

`o` - Enter insert mode on the next line

`O` - enter insert mode on the above line

`C` or `c$` - Delete from cursor to end of line and begin insert. Note that `D` or `d$` deletes current line all the way to end position.

`J` - join two lines together. `8J` to join 8 lines together. `gJ` to join two lines but keep the original spacing (rarely used).
