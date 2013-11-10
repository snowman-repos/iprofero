# iProfero Living Styleguide

This styleguide is for the purpose of specifying and showcasing all the styles used throughout the project. The styleguide is automatically generated from the project stylesheets (stylus files) using KSS.

The project uses Semantic UI ([http://semantic-ui.com/](http://semantic-ui.com/)).

## Coding Style:

### General Rules

* TAB indentation
* Property declarations in alphabetical order
* Style properties to be vertically aligned throughout the style sheet
* No colons or semi colons in declarations
* No curly braces
* Style blocks to be separated by at least 2 line breaks
* Use `//` for comment blocks, not `/* */`
* Use `rem` or `em` for font sizes, not `px`, with a `px` fallback
* Never use ID selectors, only classes (IDs for JS only)
* No more than 3 nested selectors
* Class names `disabled`, `mousedown`, `danger`, `hover`, `selected`, and `active` should **always** be namespaced, e.g. `button.hover`
* Multi-line
* Indent vendor-prefixed declarations so that their values are aligned
* English spelling :)
* Tags in comments: ^tag
* No widths, ever. Everything should be fluid with widths handled by the grid system.
* Heights for images and sprites only. Height may be controlled using `line-height`
* NEVER style grid/container elements, and especially don't apply box-model properties. Style elements inside instead
* Only use shorthand declarations when you don't need to be explicit. e.g. use `margin-bottom 0` instead of `margin 0`
* Use `!important` on helper classes only and use preemptively, not reactively
* No magic numbers e.g. `margin-top 47px` - every hard-coded measurement you set is a commitment you might not necessarily want to keep
* DEBUGGING: If you run into a CSS problem take code away before you start adding more in a bid to fix it. The problem exists in CSS that is already written, more CSS isn’t the right answer! Don't use `overflow hidden` to hide quirks - **fix the problem, not its symptoms**
* STYLUS: avoid nesting! use it only where it would be required in vanilla CSS. BEM notation can help avoid nesting

### Source Order

* Reset - ground zero
* Elements - unclassed `h1`, unclassed `ul` etc.
* Objects and Abstractions - generic, underlying patterns
* Components - full components constructed from objects and their extensions
* Style trumps - error states, debug code etc.

As you go down the CSS document, each section should inherit from previous sections. There should be less undoing of styles, less specificity problems and all-round better architected stylesheets.

### Class Naming Conventions

* Never reference `-js` suffixed class names from style sheets - these are exclusively for JS files
* Use the `-is` suffix for classes shared between CSS and JavaScript
* Try to use "semantic" class names that offer meaning
* Follow BEM naming conventions - hyphen or underscore delimited class names
* Class names should be as short as possible, but as long as they need to be
* Using BEM notation generally removes the need for nested or overqualified selectors
* Be explicit; target the element you want to affect, not its parent. **Never assume that markup won’t change. Write selectors that target what you want, not what happens to be there already**
* Make sure your key selector is never an element/type selector or object/abstraction class. We never really want to see selectors like `.sidebar ul{}` or `.footer .media{}` in our stylesheets

```
.block
.block__element
.block__element--modifier
```
e.g.
```
.person
.person--woman
.person__hand
.person__hand--left
```