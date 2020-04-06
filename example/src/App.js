/**
 * Sample React Native App
 *
 */

import React, {useState, useEffect} from 'react';
import {StyleSheet, Text, View, SafeAreaView, ScrollView} from 'react-native';
import Button from './components/Button'
import Header from './components/Header';
import Input from './components/Input';
import InputSpacer from './components/InputSpacer';
import YotiDocScan from '@getyoti/react-native-yoti-doc-scan';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    backgroundColor: '#f5f5f5',
  },
  welcome: {
    fontFamily: 'Prompt-SemiBold',
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
    fontFamily: 'Prompt-Medium',
    fontSize: 12,
    marginBottom: 15,
  },
  results: {flexGrow: 1, paddingHorizontal: 20},
  resultsContainer: {
    flex: 1,
    width: '100%',
    alignSelf: 'center',
    marginBottom: 30,
  },
  resultsHeader: {paddingTop: 5, width: 200},
  resultsHeaderText: {
    textAlign: 'center',
    fontFamily: 'Prompt-Medium',
    color: 'white',
  },
  resultTitle: {
    color: '#444',
    fontFamily: 'Prompt-SemiBold',
    fontSize: 16,
    marginBottom: 0,
  },
  resultDescription: {
    color: '#475056',
    fontFamily: 'Prompt-ExtraLight',
    fontSize: 8,
    marginTop: 15,
  },
  resultText: {
    color: '#444',
    fontFamily: 'Prompt-Regular',
    fontSize: 12,
    marginBottom: 15,
  },
  resultRow: {flexDirection: 'row'},
  resultRowIcon: {fontSize: 12, marginTop: 5, marginRight: 5},
  resultsScrollViewContainer: {
    backgroundColor: 'white',
    borderWidth: 3,
    paddingVertical: 10,
    paddingHorizontal: 20,
  },
  gutter: {paddingHorizontal: 20, paddingVertical: 20},
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
  const [sessionId, setSessionId] = useState('');
  const [clientSessionToken, setClientSessionToken] = useState('');

  const showYotiButton =
    sessionId.length > 0 &&
    clientSessionToken.length > 0

  useEffect(() => {
    if (!showYotiButton) {
      setCode(null)
      setDescription(null)
    }
  }, [showYotiButton])

  return (
    <>
      <SafeAreaView style={styles.container}>
        <Header />
        <View style={{flex: 1, justifyContent: 'space-between', width: '100%'}}>
          <View style={styles.gutter}>
            <Text style={styles.intro}>
              Please fill in the required information below, and tap the button once you are done.
            </Text>
          </View>
          <View style={styles.results}>
            {code != null &&
              <Results code={code} description={description} />
            }
          </View>
          <View>
            <View style={styles.inputsTopGutter}>
              <Input
                placeholder="Session ID"
                value={sessionId}
                onChangeText={setSessionId}
              />
              <InputSpacer />
              <Input
                placeholder="Session Token"
                value={clientSessionToken}
                onChangeText={setClientSessionToken}
              />
              <InputSpacer />
            </View>

            <View style={styles.yotiButton}>
              {showYotiButton && (
                <Button
                  onPress={() => {
                    const onSuccess = (code, description) => {
                      setCode(code)
                      setDescription(description)
                    }
                    const onError = (code, description) => {
                      setCode(code)
                      setDescription(description)
                    }
                    YotiDocScan.startSession(sessionId, clientSessionToken, onSuccess, onError);
                  }}
                  title="START SESSION"
                />
              )}
            </View>
          </View>
        </View>
      </SafeAreaView>
    </>
  );
};

function Results({code, description}) {
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
          {isSuccessOutcome ? 'SUCCESS' : 'ERROR'}
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
              <Text style={styles.resultTitle}>Code: {code}</Text>
              <Text style={styles.resultDescription}>
                Description:
              </Text>
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
