import React, {useState} from 'react';
import {StyleSheet, Text, View, SafeAreaView, ScrollView} from 'react-native';
import Button from './Button'
import Header from './Header';
import Input from './Input';
import InputSpacer from './InputSpacer';
import RNYotiDocScan from '@getyoti/yoti-doc-scan-react-native';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    backgroundColor: '#f5f5f5',
  },
  welcome: {
    fontSize: 20,
    color: '#444',
    textAlign: 'center',
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  intro: {
    color: '#475056',
    fontSize: 16,
    marginTop: 5,
    marginBottom: 5,
  },
  results: {
    flexGrow: 1,
    paddingHorizontal: 20,
  },
  resultsContainer: {
    flex: 1,
    width: '100%',
    alignSelf: 'center',
    marginBottom: 30,
  },
  resultsHeader: {
    paddingTop: 5,
    width: 200,
  },
  resultsHeaderText: {
    textAlign: 'center',
    color: 'white',
  },
  resultTitle: {
    color: '#444',
    fontSize: 16,
    marginTop: 4,
  },
  resultText: {
    color: '#444',
    fontSize: 14,
    marginTop: 8,
    marginBottom: 4,
  },
  resultRow: {
    flexDirection: 'row',
  },
  resultRowIcon: {
    fontSize: 12,
    marginTop: 5,
    marginRight: 5,
  },
  resultsScrollViewContainer: {
    backgroundColor: 'white',
    borderWidth: 3,
    paddingVertical: 10,
    paddingHorizontal: 20,
  },
  gutter: {
    paddingHorizontal: 20,
    paddingVertical: 20,
  },
  yotiButton: {
    height: 60,
    alignSelf: 'center',
  },
  inputsTopGutter: {
    marginVertical: 20,
    width: '100%',
    borderBottomColor: '#d5dae0',
    borderBottomWidth: 2,
    borderTopColor: '#d5dae0',
    borderTopWidth: 2,
  },
});

export default () => {
  const [code, setCode] = useState(null);
  const [description, setDescription] = useState(null);
  const [sessionID, setSessionID] = useState('');
  const [sessionToken, setSessionToken] = useState('');

  return (
    <>
      <SafeAreaView style={styles.container}>
        <Header />
        <View style={{flex: 1, justifyContent: 'space-between', width: '100%'}}>
          <View style={styles.gutter}>
            <Text style={styles.intro}>
              Fill in the session ID and token, then start the session.
            </Text>
          </View>
          <View style={styles.results}>
            {code != null &&
              <Result code={code} description={description} />
            }
          </View>
          <View>
            <View style={styles.inputsTopGutter}>
              <Input
                placeholder="Session ID"
                value={sessionID}
                onChangeText={setSessionID}
              />
              <InputSpacer />
              <Input
                placeholder="Session token"
                value={sessionToken}
                onChangeText={setSessionToken}
              />
              <InputSpacer />
            </View>
            <View style={styles.yotiButton}>
              <Button
                onPress={() => {
                  RNYotiDocScan.start(sessionID, sessionToken, (code, description) => {
                    setCode(code);
                    setDescription(description);
                  });
                }}
                title="Start"
              />
            </View>
          </View>
        </View>
      </SafeAreaView>
    </>
  );
};

function Result({code, description}) {
  const isSuccessOutcome = code == 0;
  return (
    <View style={styles.resultsContainer}>
      <View
        style={[
          styles.resultsHeader,
          {
            backgroundColor: !isSuccessOutcome ? '#fb7570' : '#37c58f',
          },
        ]}>
        <Text style={styles.resultsHeaderText}>
          {isSuccessOutcome ? 'Success' : 'Error'}
        </Text>
      </View>

      <View
        style={[
          styles.resultsScrollViewContainer,
          {
            borderColor: !isSuccessOutcome ? '#fb7570' : '#37c58f',
          },
        ]}>
        <ScrollView>
          <View style={styles.resultRow}>
            <View>
              <Text style={styles.resultTitle}>Status code: {code}</Text>
              <Text style={styles.resultText}>
                {description != null ? description : 'No description was returned.'}
              </Text>
            </View>
          </View>
        </ScrollView>
      </View>
    </View>
  );
}
