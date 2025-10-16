package com.github.capntrips.kernelflasher.common.extensions

import kotlin.ByteArray
import kotlin.collections.joinToString

object ByteArray {
    fun ByteArray.toHex(): String = joinToString(separator = "") { "%02x".format(it) }
}
