[![Build Status](https://travis-ci.org/emeraldion/bocadillo.svg?branch=master)](https://travis-ci.org/emeraldion/bocadillo)

# bocadillo

Converts a list of strings into a compact, readable representation with delimiters of choice

```
bocadillo 'alba,albero,albergo,alberto'
# => alb(a|er(go|o|to))

bocadillo 'aria:arianna' ':' '[' '+' ']'
# => aria[+nna]
```

## What?

In Spanish, [bocadillo](https://es.wiktionary.org/wiki/bocadillo) means sandwich. The name hints at the strings being sliced and interleaved with bread, the delimiters. Bocadillo is the Ruby port of the PHP package [Tramezzino](https://packagist.org/packages/emeraldion/tramezzino).

## Why?

Useful when you need to pass long lists of URL params

## Ruby Gem

Add it to your Ruby project as a [Ruby Gem](https://rubygems.org):

```sh
gem install bocadillo
```

Then have it your way:

```ruby

```

## License

Copyright (c) 2017, Claudio Procida

[MIT](https://opensource.org/licenses/MIT)
