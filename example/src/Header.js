import React from 'react';
import {Image, StyleSheet, Text, View} from 'react-native';

const styles = StyleSheet.create({
  icon: {
    width: 109.375 * 2/3,
    height: 50 * 2/3,
    marginTop: 15,
  }
});

function Header() {
  return (
    <View>
      <Image
        source={require('../yoti.png')}
        style={styles.icon}
      />
    </View>
  );
}

export default Header;
