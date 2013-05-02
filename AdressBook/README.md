## 学んだこと

### Gemfileに'bubble-wrapper'も書く必要がある

Gemfileには'motion-addressbook'だけ書けば良いかと思ったが、'bubble-wrapper'gemも明示的に書いてあげないと`rake`と打つと

```
rake aborted!
uninitialized constant BubbleWrap
```

となってしまう。

## 参考

- [iOSAddress Bookプログ
ラミングガイド](https://developer.apple.com/jp/devcenter/ios/library/documentation/AddressBookProgrammingGuideforiPhone.pdf)
- [github: motion-addressbook](https://github.com/alexrothenberg/motion-addressbook)
