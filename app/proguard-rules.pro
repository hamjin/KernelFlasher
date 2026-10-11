# ---------------------------------------------------------------------------
# kotlinx.serialization
# Json.decodeFromString<T>() / encodeToString(value) resolve the generated
# serializer reflectively; these rules keep the lookup working under R8.
# ---------------------------------------------------------------------------
-keepattributes *Annotation*, InnerClasses

# Keep the Companion field of serializable classes (serializer lookup path).
-if @kotlinx.serialization.Serializable class **
-keepclassmembers class <1> {
    static <1>$Companion Companion;
}

# Keep serializer()/childSerializers() on the generated companion objects.
-if @kotlinx.serialization.Serializable class ** {
    static **$* *;
}
-keepclassmembers class <2>$<3> {
    kotlinx.serialization.KSerializer serializer(...);
    kotlinx.serialization.KSerializer[] childSerializers();
}

# Keep generated $$serializer classes and their descriptor data.
-keep,includedescriptorclasses class **$$serializer { *; }

# Keep the serializable data models themselves (Backup, Partitions, FstabEntry,
# Update — written to backup.json, fetched over the network, stored via Room).
-keep @kotlinx.serialization.Serializable class ** { *; }

# ---------------------------------------------------------------------------
# libsu RootService
# FilesystemService is loaded reflectively (by class name) inside the root
# process, so the class and its public no-arg constructor must survive R8.
# ---------------------------------------------------------------------------
-keep public class * extends com.topjohnwu.superuser.ipc.RootService {
    public <init>();
}

# ---------------------------------------------------------------------------
# AIDL Binder stubs used for root IPC (IFilesystemService)
# ---------------------------------------------------------------------------
-keep class **$Stub { *; }
-keepclassmembers class **$Stub$Proxy { *; }