/**
* @file transmitter.h
* @brief management of tramsit features - header
* @author Alberto Trentadue, IZ0CEZ
* @version 0.1
* @date 2012-02-10
*/

#define TRANSMIT_BUFFER_SIZE 1024

typedef struct _transmitter {    
    int tx_audio_socket;
    pthread_t audio_thread_id;
    CLIENT* client;
    float output_buffer[TRANSMIT_BUFFER_SIZE*2];
    int   samples;
} TRANSMITTER;

extern TRANSMITTER transmitter;

/*!
 * The Transmitter initialiser
 */
void init_transmitter(void);

/*!
 * Activates the transmitter to a client
 */
const char* attach_transmitter(CLIENT* client);

/*!
 * Dectivates the transmitter from a client
 */
const char* detach_transmitter(CLIENT* client);

/*!
 * The thread receiving TX audio IQ samples from dspserver
 */ 
void* tx_audio_thread(void* arg);

/*!
 * ???? 
 */ 
void process_microphone_samples();
