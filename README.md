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

(RECOMMENDED METHOD) A more efficient animation:

    EzAnimation animation = EzAnimation(10.0, 100.0, Duration(seconds: 1), context: context);

ANOTHER METHOD: (Note that this animation needs to be manually stopped or it will go to completion even when another screen is pushed.)

    EzAnimation animation = EzAnimation(10.0, 100.0, Duration(seconds: 1));

(Notice that you can define this outside of initState, unlike normal animation controllers)

### START ANIMATION

    animation.start();
    
    // OR
    
    animation.start(from: 0.2);

### END ANIMATION

    animation.stop();

## REPEAT ANIMATION

    animation.repeat();

## RESET ANIMATION

    animation.reset();

### REVERSE ANIMATION

    animation.reverse();
    
    // OR
    
    animation.reverse(from: 0.5);

### DEFINE WHAT HAPPENS WHEN NAVIGATOR PUSHES ANOTHER PAGE ON TOP

    EzAnimation animation = EzAnimation(10.0, 100.0, Duration(seconds: 1), context: context, onNavigate: OnNavigate.pauseAnimation);

An animation can either reset or pause when the navigator pushes another page on top. Use the onNavigate page to achieve this.

NOTE: A PAUSED ANIMATION NEEDS TO BE MANUALLY RESTARTED AFTER COMING BACK TO THE MAIN PAGE

    onPressed: () async {
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => DemoPage()));
        animation.start();
    }

    resetAnimation -> Resets animation to the start
    pauseAnimation -> Pauses animation at that instant (You need to manually restart this when it comes back)
    letItRun -> Animation will go to completion unless animation.stop() is called.
    takeToEnd -> Takes animation to final value instantly

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

### USE ANIMATION SEQUENCES

You can have multiple animations running in series with weights with EzAnimation.sequence()

    EzAnimation ezAnimation = EzAnimation.sequence([
      SequenceItem(0.0, 100.0, weight: 2),
      SequenceItem(100.0, 50.0),
      SequenceItem(50.0, 100.0),
    ], Duration(seconds: 2), context: context);

    ezAnimation.start();

### USE SPECIALIZED TWEENS

Use the EzAnimation.tween() to pass in other Tween types such as ColorTween

    EzAnimation ezAnimation = EzAnimation.tween(ColorTween(begin: Colors.red, end: Colors.blue), Duration(seconds: 2), context: context);
    
    ezAnimation.start();

Similarly, the EzAnimation.tweenSequence allows you to create a sequence with ColorTweens and other tweens

    EzAnimation ezAnimation = EzAnimation.tweenSequence(TweenSequence([
        TweenSequenceItem(tween: ColorTween(begin: Colors.red, end: Colors.blue), weight: 1.0),
        TweenSequenceItem(tween: ColorTween(begin: Colors.red, end: Colors.blue), weight: 2.0),
    ]), Duration(seconds: 2), context: context);
