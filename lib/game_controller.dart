import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_apps/enemy.dart';
import 'package:flutter_apps/enemy_spawner.dart';
import 'package:flutter_apps/health_bar.dart';
import 'package:flutter_apps/high_score.dart';
import 'package:flutter_apps/player.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter_apps/score_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_apps/state.dart';

class GameController extends Game {
  final SharedPreferences storage;

  Random rand;
  Size screenSize;
  double tileSize;

  Player player;
  List<Enemy> enemies;
  HealthBar healthBar;
  EnemySpawner enemySpawner;

  int score;
  ScoreText scoreText;

  GameState state;

  HighScoreText highScoreText;

  GameController(this.storage) {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    state = GameState.menu;
    rand = Random();
    player = Player(this);
    enemies = List<Enemy>();
    enemySpawner = EnemySpawner(this);
    healthBar = HealthBar(this);
    score = 0;
    scoreText = ScoreText(this);
    highScoreText = HighScoreText(this);
    // spawnEnemy();
  }

  @override
  void render(Canvas canvas) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint();
    backgroundPaint.color = Color(0xFFFAFAFA);
    canvas.drawRect(background, backgroundPaint);

    player.render(canvas);

    if (state == GameState.menu) {
      highScoreText.render(canvas);
      // start button render

    } else {
      enemies.forEach((Enemy enemy) => enemy.render(canvas));
      healthBar.render(canvas);
      scoreText.render(canvas);
    }
  }

  @override
  void update(double t) {
    if (state == GameState.menu) {
      highScoreText.update(t);
      // start button update
    } else {
      enemySpawner.update(t);
      enemies.forEach((Enemy enemy) => enemy.update(t));
      enemies.removeWhere((Enemy enemy) => enemy.isDead);
      player.update(t);
      scoreText.update(t);
      healthBar.update(t);
    }
  }

  @override
  void resize(Size size) {
    super.resize(size);

    // if (size != null) {
    screenSize = size;
    tileSize = screenSize.width / 10;
    // }
  }

  void onTapDown(TapDownDetails d) {
    // handle taps here

    if (state == GameState.menu) {
      print('START');
      state = GameState.play;
    } else {
      enemies.forEach((enemy) {
        if (enemy.enemyRect.contains(d.globalPosition)) {
          enemy.onTapDown();
        }
      });
    }
  }

  void spawnEnemy() {
    double x, y;
    switch (rand.nextInt(4)) {
      case 0:
        // top
        x = rand.nextDouble() * screenSize.width;
        y = -tileSize * 2.5;
        break;
      case 1:
        // right
        x = screenSize.width + tileSize * 2.5;
        y = rand.nextDouble() * screenSize.height;
        break;

      case 2:
        // bottom
        x = rand.nextDouble() * screenSize.width;
        y = screenSize.height + tileSize * 2.5;
        break;

      case 3:
        // left
        x = -tileSize * 2.5;
        y = rand.nextDouble() * screenSize.height;
        break;
    }

    enemies.add(Enemy(this, x, y));
  }
}
