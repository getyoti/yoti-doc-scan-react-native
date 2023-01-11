type Enumerate<N extends number, Acc extends number[] = []> = Acc['length'] extends N
  ? Acc[number]
  : Enumerate<N, [...Acc, Acc['length']]>

type IntRange<F extends number, T extends number> = Exclude<Enumerate<T>, Enumerate<F>>

type RGBValue = IntRange<0, 255>

export type YotiStatusRequest = (code: string, description: string) => void;

export const startSession: (
  sessionId: string,
  clientSessionToken: string,
  onSuccess: YotiStatusRequest,
  onError: YotiStatusRequest,
) => void;

export const setPrimaryColorRGB: (red: RGBValue, green: RGBValue, blue: RGBValue) => void;

export const setRequestCode: (port: number) => void;

/** @link https://github.com/getyoti/yoti-doc-scan-react-native#usage */
export enum YOTI_RESULTS_MAP {
  SUCCESS = 0,
  USER_CANCELLATION = 1000,
  /** 
   * @description Can retry? Yes
   * @summary Wrong or expired session token 
   * */
  UNAUTHORISED = 2000,
  /** @description Can retry? Yes */
  SESSION_NOT_FOUND = 2001,
  /** @description Can retry? Yes */
  SDK_LAUNCHED_WITHOUT_SESSION_TOKEN = 2003,
  /** @description Can retry? Yes */
  SDK_LAUNCHED_WITHOUT_SESSION_ID = 2004,
  /** @description Can retry? Yes */
  YOTI_SERVICES_DOWN = 3000,
  /** @description Can retry? Yes */
  NETWORK_ERROR = 3001,
  /** @description Can retry? Yes */
  NO_NETWORK_CONNECTION = 3002,
  /** @description Can retry? Yes */
  NO_CAMERA_PERMISSION = 4000,
  NO_CAMERA = 5000,
  /** @description Can retry? Yes */
  NO_MORE_LOCAL_TRIES_FOR_LIVENESS = 5002,
  SDK_OUT_OF_DATE = 5003,
  UNEXPECTED_INTERNAL_ERROR = 5004,
  UNEXPECTED_DOCUMENT_SCANNING_ERROR = 5005,
  UNEXPECTED_LIVENESS_ERROR = 5006,
  DOCUMENT_CAPTURE_DEPENDENCY_NOT_FOUND_ERROR = 6000,
  LIVENESS_ZOOM_DEPENDENCY_NOT_FOUND_ERROR = 6001,
  SUPPLEMENTARY_DOCUMENT_DEPENDENCY_NOT_FOUND_ERROR = 6002,
}
