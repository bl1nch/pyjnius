# on android, rely on SDL or Flet to get the JNI env
from os import environ
from libc.stdint cimport uintptr_t


FLET_JNIENV = environ.get('FLET_JNIENV')
cdef jlong flet_jnienv_addr = 0

if FLET_JNIENV:
    flet_jnienv_addr = <jlong>int(FLET_JNIENV)

cdef extern JNIEnv *SDL_AndroidGetJNIEnv()


cdef JNIEnv *get_platform_jnienv() except NULL:
    if FLET_JNIENV:
        return <JNIEnv*>(<uintptr_t>flet_jnienv_addr)
    return <JNIEnv*>SDL_AndroidGetJNIEnv()
