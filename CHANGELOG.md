# 1.0.0 Soon!!!

# 0.12.2

- Add the possibility to disable changing the scroll view `contentInset` automatically
- Optimise the arrangement of the header view inside the scroll view

# 0.12.1

- Fix crash when removing from scroll view

# 0.12.0

- Remove dependency on `KVOController``
- Remove test dependencies on `Expecta` and `OCMock`
- Create library project to generate a framework
- Support [Carthage](https://github.com/Carthage/Carthage)
- Support test coverage display via [Coveralls](https://coveralls.io)

# 0.11.0

- **New functionality**: add [new mode](https://github.com/gskbyte/GSKStretchyHeaderView/blob/master/Pod/Classes/GSKStretchyHeaderView.h#L64) for immediate expansion when scrolling down. Showcased in the examples *With tabs*, *From a XIB file* and *Scalable Text*)
- Improved how the header view is rearranged inside the scroll view: it won't cover the scrollbars anymore
- Rename `contentBounces` to `contentExpands`
- Rename `contentStretches` to `contentShrinks`
- Refactor layout code: stretchy header frame is configured in the scrollview

# 0.10.0

- Move `UIView+GSKLayoutHelper` to the example project, because its functionality shouldn't belong to the library and the method names may collide with others
- Add a new example resizing a `UILabel`

# 0.9.0

- Simplify internal code thanks to [`KVOController`](https://github.com/facebook/KVOController)
- Add lots of tests (coverage **above 94%**)
- Add Twitter example
- Fix a couple of smaller issues

# 0.8.2

- Make stretchy header view stay always on top, so that section headers and footers do not overlap it.

# 0.8.1

- `contentInset` recalculation bugfixes
- Add airbnb-like example

# 0.8.0 Improved API

- Add new anchorMode
- Add `contentInset` property
- Add code documentation
- Unify stretchFactor properties

# 0.7.0 Initial version

- Initial working version
