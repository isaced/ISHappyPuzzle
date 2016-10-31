# ISHappyPuzzle
just want to hapyy puzzle!

- Swift3
- Xcode8

![screenshot](https://raw.github.com/isaced/ISHappyPuzzle/master/screenshot.gif)

#### Layout

很方便的使用 JSON 文件来组织布局模型数据，格式如下：

```
[        
	{
		"x": 0.587,
		"y": 0.490,
		"width": 0.384,
		"height": 0.215
	},
	...
]
```

这是每一块的表示，多个块包在一个数组里即可。

#### Go

使用非常简单，可以从文件或者网络中读取布局模型数据，然后通过 `ISHappyPuzzleView` 装载：

```
// 初始化
let puzzleView = ISHappyPuzzleView()

// 加载布局
puzzleView.loadLayout(layoutInfo)

// 截图
let screenshot = puzzleView.screenShot()
```



...

#### Cocoapods

```
pod 'ISHappyPuzzle'
```
