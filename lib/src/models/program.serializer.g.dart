// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program.dart';

// **************************************************************************
// SerializerGenerator
// **************************************************************************

abstract class ProgramNodeSerializer {
  static ProgramNode fromMap(Map map) {
    if (map['entry_point'] == null) {
      throw new FormatException(
          "Missing required field 'entry_point' on ProgramNode.");
    }

    if (map['functions'] == null) {
      throw new FormatException(
          "Missing required field 'functions' on ProgramNode.");
    }

    return new ProgramNode(
        entryPoint: map['entry_point'] as ExpressionNode,
        functions: map['functions'] as List<FunctionNode>);
  }

  static Map<String, dynamic> toMap(ProgramNode model) {
    if (model == null) {
      return null;
    }
    if (model.entryPoint == null) {
      throw new FormatException(
          "Missing required field 'entry_point' on ProgramNode.");
    }

    if (model.functions == null) {
      throw new FormatException(
          "Missing required field 'functions' on ProgramNode.");
    }

    return {'entry_point': model.entryPoint, 'functions': model.functions};
  }
}

abstract class ProgramNodeFields {
  static const String entryPoint = 'entry_point';

  static const String functions = 'functions';
}
