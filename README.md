![Clay Containers for implementing beautiful, modern neumorphic designs.](https://res.cloudinary.com/mca62511/image/upload/v1579847668/banner_zx6prd.png)

# Clay Containers

Easily create and customize beautiful, modern [neumorphic](https://dribbble.com/tags/neumorphism) containers for your Flutter project. These clay containers can become the basis for your own unique neumorphic designs. 

## Installation 

Add `clay_containers` to your project as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/packages-and-plugins/using-packages). This is a simple Dart plugin, so additional configuration for iOS and Android is not needed.

## Examples

### Simple `ClayContainer`
For best results, set the background
color of a surrounding widget to match
the color you will set for your clay
container. Since it is likely you'll reuse this base color
multiple times (especially if you end up doing something fancy)
it's good to set this color to a single value. In the following example it
is set to `baseColor`.

```
import 'package:clay_containers/clay_containers.dart';

class MyExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color baseColor = Color(0xFFF2F2F2);

    return Container(
        color: baseColor,
        child: Center(
          child: ClayContainer(
            color: baseColor,
            height: 200,
            width: 200,
          ),
        ),
      );
  }
}
```

![ClayContainer example.](https://res.cloudinary.com/mca62511/image/upload/v1579847714/simple_xeh3pd.png)

### `ClayContainer` with a `ClayText` Child.

In the previous example the `ClayContainer` was given `height`
and `width` since it has no child. `ClayContainer` behaves the
same as a normal `Container` and needs to be either given
`height` and `width` or a `child` to be visible. In the
following example, the `ClayContainer` will receive a child.

The child it will receive is a `ClayText` wrapped in some `Padding`. 

```
ClayContainer(
          color: baseColor,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: ClayText("Seize the Clay!", emboss: true, size: 40),
          ),
        ),
```

![Clay container example with child.](https://res.cloudinary.com/mca62511/image/upload/v1579847742/simple_child_text_jmwjd3.png)

### Rounded `ClayContainer`s

Don't be a square! Use borderRadius to add some flare. If you want a uniform `borderRadius` you can simply set it directly in the `ClayContainer` constructor.

```
ClayContainer(
          color: baseColor,
          height: 150,
          width: 150,
          borderRadius: 50,
        ),
```
![A rounded ClayContainer.](https://res.cloudinary.com/mca62511/image/upload/v1579847766/circle_ci1at9.png)

If you want to pass your own custom `BorderRadius` object, that is available as well: In that case pass it to `customBorderRadius`. 

```
ClayContainer(
          color: baseColor,
          height: 150,
          width: 150,
          customBorderRadius: BorderRadius.only(
              topRight: Radius.elliptical(150, 150),
              bottomLeft: Radius.circular(50)),
        ),
```
![A weird shaped ClayContainer.](https://res.cloudinary.com/mca62511/image/upload/v1579847787/weird_pv8vnk.png)

### Embossed `ClayContainer`s

You may have noticed earlier that the `ClayText` can receive an `emboss` property. ClayContainers can as well. All clay widgets start in a debossed state by default. 

```
ClayContainer(
          emboss: true,
          color: baseColor,
          height: 150,
          width: 150,
          borderRadius: 50,
        ),
```
![An embossed ClayContainer.](https://res.cloudinary.com/mca62511/image/upload/c_scale,w_570/v1579930865/ss__2020-01-25_at_14.34.08_hntksj.png)

### Change Default Spread and Depth

Don't like the default look of the neumorphic effect? Change the base variables. Do whatever you want. I'm not your mom. 

```
ClayContainer(
          color: baseColor,
          height: 150,
          width: 150,
          borderRadius: 75,
          depth: 40,
          spread: 40,
        ),
```
![Embossed!](https://res.cloudinary.com/mca62511/image/upload/v1579847841/deep_v010zd.png)

### Concave and Convex `ClayContainer`s

Give your `ClayContainer` a convex or a concave look by passing either `CurveType.concave` or `CurveType.convex` to the `curveType` parameter. 

```
Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClayContainer(
              color: baseColor,
              height: 150,
              width: 150,
              borderRadius: 75,
              curveType: CurveType.concave,
            ),
            SizedBox(width: 50),
            ClayContainer(
              color: baseColor,
              height: 150,
              width: 150,
              borderRadius: 75,
              curveType: CurveType.none,
            ),
            SizedBox(width: 50),
            ClayContainer(
              color: baseColor,
              height: 150,
              width: 150,
              borderRadius: 75,
              curveType: CurveType.convex,
            ),
          ],
        ),
```
![Concave, flat, and convex ClayContainers.](https://res.cloudinary.com/mca62511/image/upload/v1579847860/concave_convex_hyafpx.png)

### Animate It!

Animation is not something included in this plugin, but having these values abstracted makes it easier to do things like animate your neumorphic elements. You can find the source for the example image below in this project's `./example` folder. 

![Very animated. Much cool.](https://res.cloudinary.com/mca62511/image/upload/c_scale,h_300,w_300/v1579847878/animated_rktpdo.gif)

### Full API Documentation

#### `ClayContainer`

##### Positional Arguments

None. 

##### Named Arguments

* **color** - This sets the base color for the clay object. Simply setting this to the background color of the parent object will give you a pretty good looking debossed neumorphic effect.
* **height** - This sets the height of the container.
* **width** - This sets the width of the container.
* **parentColor** - This tells the widget to use a different color for the outside emboss/deboss effect, despite whatever is set in the `color` field.
* **surfaceColor** - This tells the widget to use a different color for the inside of the container, despite whatever is set in the `color` field.
* **spread** - How far should the emboss/deboss effect spread?
* **depth** - How strong should the emboss/deboss effect be?
* **child** - This receives child widgets.
* **borderRadius** - This receives a number representing a border radius to be applied to all corners of the container.
* **customBorderRadius** - This receives a `BorderRadius` object. Setting this object will override whatever is set in the `borderRadius` field.
* **curveType** - This receives a `CurveType` enum. Use this to set the inside surface to look either convex or concave.
* **emboss** - This is `false` by default. Set this to `true` in order to make an embossed container. 


#### `ClayText`

##### Positional Arguments

* **text** - This is the text to be displayed.

##### Named Arguments

* **color** - This sets the base color for the clay object. Simply setting this to the background color of the parent object will give you a pretty good looking debossed neumorphic effect.
* **parentColor** - This tells the widget to use a different color for the outside emboss/deboss effect, despite whatever is set in the `color` field.
* **textColor** - This tells the widget to use a different color for the fill of the text, despite whatever is set in the `color` field.
* **spread** - How far should the emboss/deboss effect spread?
* **depth** - How strong should the emboss/deboss effect be?
* **emboss** - This is `false` by default. Set this to `true` in order to make an embossed container. 