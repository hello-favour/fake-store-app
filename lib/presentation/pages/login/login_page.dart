import 'package:fake_store/core/utils/show_top_toast.dart';
import 'package:fake_store/core/utils/spinner_view.dart';
import 'package:fake_store/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/validators.dart';
import 'auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        LoginRequested(
          username: _usernameController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              context.go('/products');
            } else if (state is AuthError) {
              showToastAlert(state.message, isSuccess: false);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: SvgPicture.asset(
                        Assets.svg.arrowBack,
                        width: 20,
                        height: 20,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
                const Gap(25),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Welcome back! Glad\nto see you, Again!',
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Gap(32),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your email',
                            ),
                            validator: Validators.validateEmail,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const Gap(16),
                          TextFormField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your username',
                            ),
                            validator: Validators.validateUsername,
                            textInputAction: TextInputAction.next,
                          ),
                          const Gap(16),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              hintText: 'Enter your password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            obscureText: _obscurePassword,
                            validator: Validators.validatePassword,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _handleLogin(),
                          ),
                          const Gap(32),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              return SizedBox(
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: state is AuthLoading
                                      ? null
                                      : _handleLogin,
                                  child: state is AuthLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: SpinnerView(),
                                        )
                                      : const Text('Login'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
