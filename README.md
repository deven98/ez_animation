# ezanimation

Easy Animations - No Controllers, No Tickers, Only the necessary parts.

NO NEED TO ADD TickerProviderStateMixins
NO MORE AnimationControllers
NO MORE Tweens
EASILY ADD Curves AND ReverseCurves

## NO MORE COMPLICATION

Normal animations involve a fair amount of complexity: AnimationControllers, Tweens, Animation, Tickers are not familiar concepts to many.
Not just to beginners - when creating an explicit animation, even advanced users experience hardships dealing with the many components involved.

### ANNOUNCING EZANIMATION: A SET OF TOOLS TO MAKE ANIMATIONS MUCH EASIER

With EzAnimation, there is no need to burden your code with TickerProviders, the complicated logic of curves, different components of animation, etc.

## TO USE:

### DEFINE EzAnimation

    EzAnimation animation = EzAnimation(10.0, 100.0, Duration(seconds: 1));

(Notice that you can define this outside of initState, unlike normal animation controllers)

### START ANIMATION

    animation.start();
    
    // OR
    
    animation.start(from: 0.2);

### END ANIMATION

    animation.stop();

### REVERSE ANIMATION

    animation.reverse();
    
    // OR
    
    animation.reverse(from: 0.5);

### REBUILD UI

You can use normal listeners and rebuild UI with AnimatedBuilder as usual.

    animation.addListener(() { 
      setState(() {});
    });
    
    //OR
    
    AnimatedBuilder(
        animation: animation,
        builder: (context, snapshot) {
          return Center(
            child: Container(
              width: animation.value,
              height: animation.value,
              color: Colors.blue,
            ),
          );
        }
      ),

### ADD CURVES EASILY

    var animation = EzAnimation(10.0, 100.0, Duration(seconds: 1), curve: Curves.bounceInOut, reverseCurve: Curves.linear);

### LISTEN TO STATUS

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.reverse();
      }
    });