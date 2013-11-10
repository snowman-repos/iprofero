# AngularJS datepicker directives

## WIP

#### Requirements

-  Angular v1.1.4+
-  jQuery or your own implementation of `position()` on top of `jQuery Lite`


#### Development version 

Checkout, run `grunt install` and `bower install`.
To build run `gunt build`

## Examples

Live demo : todo


##### defaults

```html
<div date-picker="start"></div>
```


##### views:

(initial) view

```html
<div date-picker="start" view="year"></div>
```

(max) view

```html
<div date-picker="start" max-view="month"></div>
```

(min) view 

##### only date view

```html
<div date-picker="start" min-view="date"></div>
```

##### input as datepicker

```html
<input type="datetime" date-time ng-model="start">
```

##### input with formatted value

```html
<input type="datetime" date-time ng-model="end" hours format="short">
```


##### date-range picker

```html
<div date-range start="start" end="end"></div>
```
