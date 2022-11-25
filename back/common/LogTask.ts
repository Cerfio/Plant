/* eslint-disable no-console */
// const dateFormat = require('dateformat');
// import dateFormat from 'dateformat';
import emoji from 'node-emoji';
// Emoji list https://raw.githubusercontent.com/omnidan/node-emoji/master/lib/emoji.json

enum ColorEnum {
  Reset = '\x1b[0m',
  Bright = '\x1b[1m',
  Dim = '\x1b[2m',
  Underscore = '\x1b[4m',
  Blink = '\x1b[5m',
  Reverse = '\x1b[7m',
  Hidden = '\x1b[8m',
  FBlack = '\x1b[30m',
  FRed = '\x1b[31m',
  FGreen = '\x1b[32m',
  FYellow = '\x1b[33m',
  FBlue = '\x1b[34m',
  FMagenta = '\x1b[35m',
  FCyan = '\x1b[36m',
  FWhite = '\x1b[37m',
  BBlack = '\x1b[40m',
  BRed = '\x1b[41m',
  BGreen = '\x1b[42m',
  BYellow = '\x1b[43m',
  BBlue = '\x1b[44m',
  BMagenta = '\x1b[45m',
  BCyan = '\x1b[46m',
  BWhite = '\x1b[47m',
}

enum EmojiLoggerEnum {
  START_CONTROLLER = 'wrench',
  END_CONTROLLER = 'white_check_mark',
  START_HANDLER = 'bulb',
  END_HANDLER = 'bulb',
  START_SERVICE = 'open_book',
  END_SERVICE = 'blue_book',
  START_DECORATOR = 'camera',
  END_DECORATOR = 'camera_with_flash',
  ERROR = 'no_entry_sign',
}

enum StepLoggerEnum {
  START = 'START',
  END = 'END',
  ERROR = 'ERROR',
}

export class LogTaskController {
  constructor(readonly name: string) {}
  start(functionName: string) {
    console.log(
      `[${emoji.get(EmojiLoggerEnum.START_CONTROLLER)} ${
        this.name
      } ${StepLoggerEnum.START} ${ColorEnum.FYellow}${functionName}${ColorEnum.Reset}`,
    );
  }
  end(functionName: string) {
    console.log(
      `[${emoji.get(EmojiLoggerEnum.END_CONTROLLER)} ${this.name} ${
        StepLoggerEnum.END
      } ${ColorEnum.FGreen}${functionName}${ColorEnum.Reset}`,
    );
  }
  error(functionName: string) {
    console.log(
      `[${emoji.get(EmojiLoggerEnum.ERROR)} ${this.name} ${
        StepLoggerEnum.ERROR
      } ${ColorEnum.FRed}${functionName}${ColorEnum.Reset}`,
    );
  }
}

export class LogTaskService {
  constructor(readonly name: string) {}
  start(functionName: string) {
    console.log(
      `[${emoji.get(EmojiLoggerEnum.START_SERVICE)} ${this.name} ${
        StepLoggerEnum.START
      } ${ColorEnum.FYellow}${functionName}${ColorEnum.Reset}`,
    );
  }
  end(functionName: string) {
    console.log(
      `[${emoji.get(EmojiLoggerEnum.END_SERVICE)} ${this.name} ${
        StepLoggerEnum.END
      } ${ColorEnum.FGreen}${functionName}${ColorEnum.Reset}`,
    );
  }
  error(functionName: string) {
    console.log(
      `[${emoji.get(EmojiLoggerEnum.ERROR)} ${this.name} ${
        StepLoggerEnum.ERROR
      } ${ColorEnum.FRed}${functionName}${ColorEnum.Reset}`,
    );
  }
}

export class LogTaskHandler {
  constructor(readonly name: string) {}
  start(functionName: string) {
    console.log(
      `[${emoji.get(EmojiLoggerEnum.START_HANDLER)} ${this.name} ${
        StepLoggerEnum.START
      } ${ColorEnum.FYellow}${functionName}${ColorEnum.Reset}`,
    );
  }
  end(functionName: string) {
    console.log(
      `[${emoji.get(EmojiLoggerEnum.END_HANDLER)} ${this.name} ${
        StepLoggerEnum.END
      } ${ColorEnum.FGreen}${functionName}${ColorEnum.Reset}`,
    );
  }
  error(functionName: string) {
    console.log(
      `[${emoji.get(EmojiLoggerEnum.ERROR)} ${this.name} ${
        StepLoggerEnum.ERROR
      } ${ColorEnum.FRed}${functionName}${ColorEnum.Reset}`,
    );
  }
}

export class LogTaskDecorator {
  constructor(readonly name: string) {}
  start(functionName: string) {
    console.log(
      `[${emoji.get(EmojiLoggerEnum.START_DECORATOR)} ${this.name} ${
        StepLoggerEnum.START
      } ${ColorEnum.FYellow}${functionName}${ColorEnum.Reset}`,
    );
  }
  end(functionName: string) {
    console.log(
      `[${emoji.get(EmojiLoggerEnum.END_DECORATOR)} ${this.name} ${
        StepLoggerEnum.END
      } ${ColorEnum.FGreen}${functionName}${ColorEnum.Reset}`,
    );
  }
  error(functionName: string) {
    console.log(
      `[${emoji.get(EmojiLoggerEnum.ERROR)} ${this.name} ${
        StepLoggerEnum.ERROR
      } ${ColorEnum.FRed}${functionName}${ColorEnum.Reset}`,
    );
  }
}
