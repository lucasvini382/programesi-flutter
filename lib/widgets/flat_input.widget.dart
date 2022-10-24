import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Input de texto seguindo a versão atualizada do JstUI.
class JuiFlatInput2 extends StatefulWidget {
  const JuiFlatInput2({
    Key? key,
    this.textFieldKey,
    this.hintText,
    this.controller,
    this.color = Colors.blue,
    this.inputColor = const Color(0xFF213A62),
    this.disabledColor = Colors.blue,
    this.borderColor = Colors.blue,
    this.disabledBorderColor = const Color(0xFFEEEEEE),
    this.errorColor = Colors.blue,
    this.hintColor = Colors.blue,
    this.fillColor = const Color(0x11333333),
    this.buttonColor,
    this.disabled,
    this.validator,
    this.keyboardType,
    this.maxLength,
    this.maxLengthEnforcement,
    this.inputFormatters,
    this.readOnly = false,
    this.label,
    this.iconButton,
    this.onChanged,
    this.focusNode,
    this.isPassword = false,
    this.initialValue,
    this.autofillHints,
    this.textInputAction,
    this.onFieldSubmitted,
    this.isLoading,
    this.isDarkBackground = false,
    this.onTap,
    this.isLabelSmall = false,
  })  : assert(isDarkBackground == false),
        super(key: key);

  const JuiFlatInput2.secondary({
    Key? key,
    this.textFieldKey,
    this.hintText,
    this.controller,
    this.color = Colors.white,
    this.inputColor = Colors.white,
    this.disabledColor = Colors.blue,
    this.borderColor = const Color.fromRGBO(255, 255, 255, 0.7),
    this.disabledBorderColor = Colors.blue,
    this.errorColor = Colors.red,
    this.hintColor = Colors.blue,
    this.fillColor = const Color(0x00eeeeee),
    this.buttonColor,
    this.disabled,
    this.validator,
    this.keyboardType,
    this.maxLength,
    this.inputFormatters,
    this.readOnly = false,
    this.label,
    this.iconButton,
    this.onChanged,
    this.focusNode,
    this.isPassword = false,
    this.initialValue,
    this.autofillHints,
    this.textInputAction,
    this.onFieldSubmitted,
    this.isLoading,
    this.isDarkBackground = true,
    this.onTap,
    this.isLabelSmall = false,
    this.maxLengthEnforcement,
  })  : assert(isDarkBackground == true),
        super(key: key);

  final Key? textFieldKey;
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final Color color;
  final Color inputColor;
  final Color disabledColor;
  final Color errorColor;
  final Color hintColor;
  final Color borderColor;
  final Color fillColor;
  final Color disabledBorderColor;
  final bool? disabled;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool readOnly;
  final bool isPassword;
  final Function(String? value)? onChanged;

  /// Valor inicial do input.
  final String? initialValue;

  /// Ícone exibido ao final do input (lado direito).
  final Widget? iconButton;

  final bool? isLoading;

  /// Referência de foco para o input.
  final FocusNode? focusNode;

  /// Cor do botão
  final Color? buttonColor;

  /// Informa ao dispositivo qual o tipo de campo para que sejam feitas as sugestões de texto
  /// adequadas.
  final Iterable<String>? autofillHints;

  /// Ação opcional disparada quando o usuário pressiona o botão de confirmação exibido (próximo,
  /// concluir, etc).
  final TextInputAction? textInputAction;

  /// Método chamado quando o usuário pressiona o botão de ação disponível no teclado  (próximo,
  /// concluir, etc).
  final ValueChanged<String>? onFieldSubmitted;

  /// Indica se o componente está sendo aplicado sobre um fundo de cor escura.
  final bool isDarkBackground;

  // Função chamada após clique do usuário
  final Function()? onTap;

  /// Quando [true], diminui o tamanho da fonte ao topo do input.
  final bool isLabelSmall;

  @override
  State<JuiFlatInput2> createState() => _JuiFlatInput2State();
}

class _JuiFlatInput2State extends State<JuiFlatInput2> {
  bool _hidePassword = true;
  final double _iconSize = 24.0;

  void _togglePassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Estilo aplicado no texto sobre o input.
    TextStyle? labelStyle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) Text(widget.label!, style: labelStyle),
        TextFormField(
          key: widget.textFieldKey,
          initialValue: widget.initialValue,
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          autocorrect: widget.keyboardType != TextInputType.emailAddress &&
              widget.keyboardType != TextInputType.visiblePassword,
          inputFormatters: widget.inputFormatters,
          autofillHints: widget.autofillHints,
          cursorColor: widget.color,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          obscureText: _hidePassword && widget.isPassword,
          scrollPadding: const EdgeInsets.all(40.0),
          readOnly: widget.readOnly,
          maxLength: widget.maxLength,
          maxLengthEnforcement: widget.maxLengthEnforcement,
          onChanged: widget.onChanged,
          focusNode: widget.focusNode,
          onTap: widget.onTap,
          decoration: InputDecoration(
            errorMaxLines: 2,
            hintText: widget.disabled == true ? null : widget.hintText,
            fillColor: widget.fillColor,
            enabled: !(widget.disabled == true),
            contentPadding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor, width: 1.0),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: widget.disabledBorderColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor, width: 1.0),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: widget.errorColor),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: widget.errorColor),
            ),
            suffixIcon: _getSuffixIcon(),
            suffixIconConstraints: BoxConstraints(
              maxHeight: _iconSize,
            ),
          ),
        ),
      ],
    );
  }

  _getSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: _hidePassword
            ? const Icon(Icons.visibility_off)
            : const Icon(Icons.visibility),
        onPressed: () => _togglePassword(),
        iconSize: _iconSize,
        color: widget.buttonColor ?? Colors.grey,
      );
    } else if (widget.isLoading != null && widget.isLoading!) {
      return const Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 8.0, 0),
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(),
        ),
      );
    }
    return widget.iconButton;
  }
}
