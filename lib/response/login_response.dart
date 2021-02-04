import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:session/db/dbHelper.dart';
import 'package:session/model/model.dart';
import 'package:sqflite/sqflite.dart';

const String secret = "secred";

class LoginResponse {
  final baseUrl = 'http://localhost';
  User user;
  DbHelper dbHelper = DbHelper();

  Future<bool> checkAuth(String email, password) async {
    // jika email dan password salah
    //   maka tampilkan error message
    // jika berhasil generate JWT token untuk authentikasi
    //   token tersebut di simpan ke kolom token user tersebut untuk di gunakan
    //   tampilkan sukses message

    Database db = await dbHelper.initDb();
    var validateUser = await db.query("users",
        where: "email=? AND password=?", whereArgs: [email, password]);
    if (validateUser.length > 0) {
      final jwt = senderCreatesJwt(email, password);
      receiverProcessesJwt(jwt,email, password);
      return true;
    } else {
      return false;
    }
  }

  String senderCreatesJwt(String email, String password) {
    // Create a claim set
    final claimSet = new JwtClaim(
        issuer: baseUrl,
        subject: email,
        audience: <String>[email],
        jwtId: _randomString(32),
        otherClaims: <String, dynamic>{
          'typ': 'authnresponse',
          'pld': {'k': 'v'}
        },
        maxAge: const Duration(minutes: 5));

    // Generate a JWT from the claim set

    final token = issueJwtHS256(claimSet, secret);

    print('JWT: "$token"\n');

    return token;
  }

  String _randomString(int length) {
    const chars =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    final rnd = new Random(new DateTime.now().minute);
    final buf = new StringBuffer();

    for (var x = 0; x < length; x++) {
      buf.write(chars[rnd.nextInt(chars.length)]);
    }
    return buf.toString();
  }

  void receiverProcessesJwt(String token, String email, String password) {
    try {
      // Verify the signature in the JWT and extract its claim set
      final decClaimSet = verifyJwtHS256Signature(token, secret);
      print('JwtClaim: $decClaimSet\n');

      // Validate the claim set

      decClaimSet.validate(issuer: email, audience: email);

      // Use values from claim set

      if (decClaimSet.subject != null) {
        print('JWT ID: "${decClaimSet.jwtId}"');
      }
      if (decClaimSet.jwtId != null) {
        print('Subject: "${decClaimSet.subject}"');
      }
      if (decClaimSet.issuedAt != null) {
        print('Issued At: ${decClaimSet.issuedAt}');
      }
      if (decClaimSet.containsKey('typ')) {
        final dynamic v = decClaimSet['typ'];
        if (v is String) {
          print('typ: "$v"');
        } else {
          print('Error: unexpected type for "typ" claim');
        }
      }
    } on JwtException catch (e) {
      print('Error: bad JWT: $e');
    }
  }
}

// PSUEDO CODE LOGIN
// Validasi email dan password
// Fill email and password
// jika email dan password salah
//   maka tampilkan error message
// jika berhasil generate JWT token untuk authentikasi
//   token tersebut di simpan ke kolom token user tersebut untuk di gunakan
//   tampilkan sukses message

// HEADER Authorization: Bearer ${jwtToken}

// LOGIN FOrm
