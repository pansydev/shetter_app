import 'package:pansy_ui/pansy_ui.dart';

class UTextField extends StatefulWidget {
  UTextField({
    Key? key,
    this.hintText,
    this.isPassword = false,
    TextEditingController? controller,
    this.style = const UTextFieldStyle(),
    this.icon,
    this.minLines,
    this.maxLines = 1,
    this.autofocus = false,
  })  : controller = controller ?? TextEditingController(),
        super(key: key);

  final String? hintText;
  final bool isPassword;
  final TextEditingController controller;
  final UTextFieldStyle style;
  final Widget? icon;
  final int? minLines;
  final int maxLines;
  final bool autofocus;

  @override
  _UTextFieldState createState() => _UTextFieldState();
}

class _UTextFieldState extends State<UTextField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextField(
          decoration: _InputDecoration(context, widget.style, widget.hintText),
          obscureText: obscureText,
          controller: widget.controller,
          cursorColor: context.theme.iconTheme.color,
          style: context.textTheme.button,
          cursorWidth: 1.5,
          cursorRadius: DesignConstants.borderRadius.bottomLeft,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          autofocus: widget.autofocus,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.isPassword)
              UIconButton(
                Icon(obscureText ? Icons.visibility : Icons.visibility_off),
                style: UIconButtonStyle(margin: DesignConstants.padding7),
                onPressed: _switchObscure,
              ),
          ],
        ),
      ],
    );
  }

  void _switchObscure() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}

class _InputDecoration extends InputDecoration {
  _InputDecoration(
    BuildContext context,
    UTextFieldStyle style,
    String? hintText,
  ) : super(
          hintText: hintText,
          hintStyle: context.textTheme.button?.copyWith(
            color: context.textTheme.button?.color?.withOpacity(0.5),
          ),
          border: _InputBorder(context, style),
          enabledBorder: _InputBorder(context, style),
          errorBorder: _InputBorder(context, style),
          focusedBorder: _InputBorder(context, style, isFocused: true),
          disabledBorder: _InputBorder(context, style),
          focusedErrorBorder: _InputBorder(context, style),
          contentPadding: DesignConstants.padding,
          fillColor: style.backgroundColor ?? context.theme.primaryColor,
          filled: true,
          isCollapsed: true,
        );
}

class _InputBorder extends OutlineInputBorder {
  _InputBorder(
    BuildContext context,
    UTextFieldStyle style, {
    bool isFocused = false,
  }) : super(
          borderRadius: style.borderRadius ?? DesignConstants.borderRadius,
          borderSide: !isFocused
              ? BorderSide(
                  width: 2,
                  color: style.borderColor ??
                      context.theme.iconTheme.color!.withOpacity(0.1),
                )
              : BorderSide(
                  width: 2,
                  color: style.borderColor ??
                      context.theme.iconTheme.color!.withOpacity(0.3),
                ),
        );
}

class UTextFieldStyle {
  const UTextFieldStyle({
    this.backgroundColor,
    this.borderColor,
    this.padding,
    this.margin,
    this.borderRadius,
  });

  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
}
