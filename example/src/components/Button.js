import React from 'react';
import {StyleSheet, Text, TouchableOpacity, View} from 'react-native';

const styles = StyleSheet.create({
  buttonText: {
    color: '#ffffff',
    fontFamily: 'Prompt-Medium',
    fontSize: 14,
    textAlign: 'center',
  },
  container: {
    width: '100%',
    borderRadius: 4,
    backgroundColor: '#349cf7',
    paddingVertical: 10,
    paddingHorizontal: 30,
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
  }
});

function Button({onPress, title}) {
  return (
    <TouchableOpacity onPress={onPress}>
      <View style={styles.container}>
        <Text style={styles.buttonText}>{title}</Text>
      </View>
    </TouchableOpacity>
  );
}

export default Button;
