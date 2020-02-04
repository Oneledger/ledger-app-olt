/*******************************************************************************
*   Ledger Blue - Secure firmware
*   (c) 2016, 2017, 2018 Ledger
*
*  Licensed under the Apache License, Version 2.0 (the "License");
*  you may not use this file except in compliance with the License.
*  You may obtain a copy of the License at
*
*      http://www.apache.org/licenses/LICENSE-2.0
*
*  Unless required by applicable law or agreed to in writing, software
*  distributed under the License is distributed on an "AS IS" BASIS,
*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*  See the License for the specific language governing permissions and
*  limitations under the License.
********************************************************************************/

/* MACHINE GENERATED: DO NOT MODIFY */
#ifndef SYSCALL_DEFS_H
#define SYSCALL_DEFS_H

#define EXC_RETURN_THREAD_PSP 0xFFFFFFFD
#define EXC_RETURN_THREAD_MSP 0xFFFFFFF9
#define EXC_RETURN_HANDLER_MSP 0xFFFFFFF1

// called when entering the SVC Handler C
void syscall_enter(unsigned int syscall_id, unsigned int psp);
void syscall_exit(void);
unsigned int syscall_get_caller_try_ctx(unsigned int *stack_ptr);

unsigned int syscall_check_app_address(const unsigned int *const parameters,
                                       unsigned int checked_idx,
                                       unsigned int checked_length);
unsigned int syscall_check_app_flags(unsigned int flags);
unsigned int syscall_check_app_cxport(unsigned int cxport);

void os_sched_hold_r4_r11(void);
void os_sched_restore_r4_r11(unsigned int sp) __attribute((naked));
#define SYSCALL_check_api_level_ID_IN 0x60000137UL
#define SYSCALL_check_api_level_ID_OUT 0x900001c6UL
#define SYSCALL_reset_ID_IN 0x60000200UL
#define SYSCALL_reset_ID_OUT 0x900002f1UL
#define SYSCALL_nvm_write_ID_IN 0x6000037fUL
#define SYSCALL_nvm_write_ID_OUT 0x900003bcUL
#define SYSCALL_cx_rng_u8_ID_IN 0x600004c0UL
#define SYSCALL_cx_rng_u8_ID_OUT 0x90000425UL
#define SYSCALL_cx_rng_ID_IN 0x6000052cUL
#define SYSCALL_cx_rng_ID_OUT 0x90000567UL
#define SYSCALL_cx_rng_rfc6979_ID_IN 0x60000671UL
#define SYSCALL_cx_rng_rfc6979_ID_OUT 0x90000669UL
#define SYSCALL_cx_hash_ID_IN 0x6000073bUL
#define SYSCALL_cx_hash_ID_OUT 0x900007adUL
#define SYSCALL_cx_ripemd160_init_ID_IN 0x6000087fUL
#define SYSCALL_cx_ripemd160_init_ID_OUT 0x900008f8UL
#define SYSCALL_cx_sha224_init_ID_IN 0x6000095bUL
#define SYSCALL_cx_sha224_init_ID_OUT 0x9000091dUL
#define SYSCALL_cx_sha256_init_ID_IN 0x60000adbUL
#define SYSCALL_cx_sha256_init_ID_OUT 0x90000a64UL
#define SYSCALL_cx_hash_sha256_ID_IN 0x60000b2cUL
#define SYSCALL_cx_hash_sha256_ID_OUT 0x90000ba0UL
#define SYSCALL_cx_sha384_init_ID_IN 0x60000c2bUL
#define SYSCALL_cx_sha384_init_ID_OUT 0x90000cafUL
#define SYSCALL_cx_sha512_init_ID_IN 0x60000dc1UL
#define SYSCALL_cx_sha512_init_ID_OUT 0x90000deeUL
#define SYSCALL_cx_hash_sha512_ID_IN 0x60000e48UL
#define SYSCALL_cx_hash_sha512_ID_OUT 0x90000e55UL
#define SYSCALL_cx_sha3_init_ID_IN 0x60000fd1UL
#define SYSCALL_cx_sha3_init_ID_OUT 0x90000f76UL
#define SYSCALL_cx_keccak_init_ID_IN 0x600010cfUL
#define SYSCALL_cx_keccak_init_ID_OUT 0x900010d8UL
#define SYSCALL_cx_sha3_xof_init_ID_IN 0x60001140UL
#define SYSCALL_cx_sha3_xof_init_ID_OUT 0x900011e0UL
#define SYSCALL_cx_groestl_init_ID_IN 0x60001220UL
#define SYSCALL_cx_groestl_init_ID_OUT 0x90001243UL
#define SYSCALL_cx_blake2b_init_ID_IN 0x60001308UL
#define SYSCALL_cx_blake2b_init_ID_OUT 0x90001399UL
#define SYSCALL_cx_blake2b_init2_ID_IN 0x60001466UL
#define SYSCALL_cx_blake2b_init2_ID_OUT 0x90001491UL
#define SYSCALL_cx_hmac_ripemd160_init_ID_IN 0x600015cfUL
#define SYSCALL_cx_hmac_ripemd160_init_ID_OUT 0x90001576UL
#define SYSCALL_cx_hmac_sha256_init_ID_IN 0x600016d1UL
#define SYSCALL_cx_hmac_sha256_init_ID_OUT 0x90001607UL
#define SYSCALL_cx_hmac_sha512_init_ID_IN 0x600017b3UL
#define SYSCALL_cx_hmac_sha512_init_ID_OUT 0x90001719UL
#define SYSCALL_cx_hmac_ID_IN 0x600018d1UL
#define SYSCALL_cx_hmac_ID_OUT 0x900018d6UL
#define SYSCALL_cx_hmac_sha512_ID_IN 0x600019cfUL
#define SYSCALL_cx_hmac_sha512_ID_OUT 0x9000197eUL
#define SYSCALL_cx_hmac_sha256_ID_IN 0x60001a2bUL
#define SYSCALL_cx_hmac_sha256_ID_OUT 0x90001ab4UL
#define SYSCALL_cx_pbkdf2_sha512_ID_IN 0x60001be9UL
#define SYSCALL_cx_pbkdf2_sha512_ID_OUT 0x90001b83UL
#define SYSCALL_cx_des_init_key_ID_IN 0x60001c83UL
#define SYSCALL_cx_des_init_key_ID_OUT 0x90001c4dUL
#define SYSCALL_cx_des_iv_ID_IN 0x60001d27UL
#define SYSCALL_cx_des_iv_ID_OUT 0x90001dabUL
#define SYSCALL_cx_des_ID_IN 0x60001e4eUL
#define SYSCALL_cx_des_ID_OUT 0x90001efeUL
#define SYSCALL_cx_aes_init_key_ID_IN 0x60001f2bUL
#define SYSCALL_cx_aes_init_key_ID_OUT 0x90001f31UL
#define SYSCALL_cx_aes_iv_ID_IN 0x6000202cUL
#define SYSCALL_cx_aes_iv_ID_OUT 0x9000201bUL
#define SYSCALL_cx_aes_ID_IN 0x600021e2UL
#define SYSCALL_cx_aes_ID_OUT 0x9000213cUL
#define SYSCALL_cx_rsa_init_public_key_ID_IN 0x600022e5UL
#define SYSCALL_cx_rsa_init_public_key_ID_OUT 0x9000228bUL
#define SYSCALL_cx_rsa_init_private_key_ID_IN 0x60002337UL
#define SYSCALL_cx_rsa_init_private_key_ID_OUT 0x900023c3UL
#define SYSCALL_cx_rsa_generate_pair_ID_IN 0x600024a1UL
#define SYSCALL_cx_rsa_generate_pair_ID_OUT 0x900024fdUL
#define SYSCALL_cx_rsa_sign_ID_IN 0x600025c6UL
#define SYSCALL_cx_rsa_sign_ID_OUT 0x900025f3UL
#define SYSCALL_cx_rsa_verify_ID_IN 0x600026abUL
#define SYSCALL_cx_rsa_verify_ID_OUT 0x900026b3UL
#define SYSCALL_cx_rsa_encrypt_ID_IN 0x600027daUL
#define SYSCALL_cx_rsa_encrypt_ID_OUT 0x900027c9UL
#define SYSCALL_cx_rsa_decrypt_ID_IN 0x60002884UL
#define SYSCALL_cx_rsa_decrypt_ID_OUT 0x900028a7UL
#define SYSCALL_cx_ecfp_is_valid_point_ID_IN 0x6000296bUL
#define SYSCALL_cx_ecfp_is_valid_point_ID_OUT 0x90002901UL
#define SYSCALL_cx_ecfp_is_cryptographic_point_ID_IN 0x60002ae3UL
#define SYSCALL_cx_ecfp_is_cryptographic_point_ID_OUT 0x90002af0UL
#define SYSCALL_cx_ecfp_add_point_ID_IN 0x60002b17UL
#define SYSCALL_cx_ecfp_add_point_ID_OUT 0x90002bc7UL
#define SYSCALL_cx_ecfp_scalar_mult_ID_IN 0x60002cf3UL
#define SYSCALL_cx_ecfp_scalar_mult_ID_OUT 0x90002ce3UL
#define SYSCALL_cx_ecfp_init_public_key_ID_IN 0x60002dedUL
#define SYSCALL_cx_ecfp_init_public_key_ID_OUT 0x90002d49UL
#define SYSCALL_cx_ecfp_init_private_key_ID_IN 0x60002eeaUL
#define SYSCALL_cx_ecfp_init_private_key_ID_OUT 0x90002e63UL
#define SYSCALL_cx_ecfp_generate_pair_ID_IN 0x60002f2eUL
#define SYSCALL_cx_ecfp_generate_pair_ID_OUT 0x90002f74UL
#define SYSCALL_cx_ecfp_generate_pair2_ID_IN 0x6000301fUL
#define SYSCALL_cx_ecfp_generate_pair2_ID_OUT 0x900030e6UL
#define SYSCALL_cx_ecschnorr_sign_ID_IN 0x60003141UL
#define SYSCALL_cx_ecschnorr_sign_ID_OUT 0x9000314aUL
#define SYSCALL_cx_ecschnorr_verify_ID_IN 0x60003205UL
#define SYSCALL_cx_ecschnorr_verify_ID_OUT 0x900032f7UL
#define SYSCALL_cx_edward_compress_point_ID_IN 0x60003359UL
#define SYSCALL_cx_edward_compress_point_ID_OUT 0x9000332bUL
#define SYSCALL_cx_edward_decompress_point_ID_IN 0x60003431UL
#define SYSCALL_cx_edward_decompress_point_ID_OUT 0x900034caUL
#define SYSCALL_cx_eddsa_get_public_key_ID_IN 0x6000351cUL
#define SYSCALL_cx_eddsa_get_public_key_ID_OUT 0x900035bfUL
#define SYSCALL_cx_eddsa_sign_ID_IN 0x6000363bUL
#define SYSCALL_cx_eddsa_sign_ID_OUT 0x900036f6UL
#define SYSCALL_cx_eddsa_verify_ID_IN 0x600037caUL
#define SYSCALL_cx_eddsa_verify_ID_OUT 0x90003721UL
#define SYSCALL_cx_ecdsa_sign_ID_IN 0x600038f3UL
#define SYSCALL_cx_ecdsa_sign_ID_OUT 0x90003876UL
#define SYSCALL_cx_ecdsa_verify_ID_IN 0x600039f1UL
#define SYSCALL_cx_ecdsa_verify_ID_OUT 0x900039e7UL
#define SYSCALL_cx_ecdh_ID_IN 0x60003a9dUL
#define SYSCALL_cx_ecdh_ID_OUT 0x90003a94UL
#define SYSCALL_cx_crc16_ID_IN 0x60003b0eUL
#define SYSCALL_cx_crc16_ID_OUT 0x90003b3cUL
#define SYSCALL_cx_crc16_update_ID_IN 0x60003c9eUL
#define SYSCALL_cx_crc16_update_ID_OUT 0x90003cb9UL
#define SYSCALL_cx_math_cmp_ID_IN 0x60003d5bUL
#define SYSCALL_cx_math_cmp_ID_OUT 0x90003dbcUL
#define SYSCALL_cx_math_is_zero_ID_IN 0x60003e37UL
#define SYSCALL_cx_math_is_zero_ID_OUT 0x90003e50UL
#define SYSCALL_cx_math_add_ID_IN 0x60003ffbUL
#define SYSCALL_cx_math_add_ID_OUT 0x90003fd8UL
#define SYSCALL_cx_math_sub_ID_IN 0x6000409fUL
#define SYSCALL_cx_math_sub_ID_OUT 0x9000401dUL
#define SYSCALL_cx_math_mult_ID_IN 0x6000413eUL
#define SYSCALL_cx_math_mult_ID_OUT 0x900041c2UL
#define SYSCALL_cx_math_addm_ID_IN 0x600042a6UL
#define SYSCALL_cx_math_addm_ID_OUT 0x90004248UL
#define SYSCALL_cx_math_subm_ID_IN 0x6000437dUL
#define SYSCALL_cx_math_subm_ID_OUT 0x900043e0UL
#define SYSCALL_cx_math_multm_ID_IN 0x60004445UL
#define SYSCALL_cx_math_multm_ID_OUT 0x900044f3UL
#define SYSCALL_cx_math_powm_ID_IN 0x6000454dUL
#define SYSCALL_cx_math_powm_ID_OUT 0x9000453eUL
#define SYSCALL_cx_math_modm_ID_IN 0x60004645UL
#define SYSCALL_cx_math_modm_ID_OUT 0x9000468cUL
#define SYSCALL_cx_math_invprimem_ID_IN 0x600047e9UL
#define SYSCALL_cx_math_invprimem_ID_OUT 0x90004719UL
#define SYSCALL_cx_math_invintm_ID_IN 0x6000482cUL
#define SYSCALL_cx_math_invintm_ID_OUT 0x90004891UL
#define SYSCALL_cx_math_is_prime_ID_IN 0x60004948UL
#define SYSCALL_cx_math_is_prime_ID_OUT 0x900049faUL
#define SYSCALL_cx_math_next_prime_ID_IN 0x60004aa4UL
#define SYSCALL_cx_math_next_prime_ID_OUT 0x90004acbUL
#define SYSCALL_os_perso_erase_all_ID_IN 0x60004bf5UL
#define SYSCALL_os_perso_erase_all_ID_OUT 0x90004bf4UL
#define SYSCALL_os_perso_set_pin_ID_IN 0x60004cdfUL
#define SYSCALL_os_perso_set_pin_ID_OUT 0x90004c95UL
#define SYSCALL_os_perso_set_current_identity_pin_ID_IN 0x60004dfeUL
#define SYSCALL_os_perso_set_current_identity_pin_ID_OUT 0x90004d0aUL
#define SYSCALL_os_perso_set_seed_ID_IN 0x60004ebcUL
#define SYSCALL_os_perso_set_seed_ID_OUT 0x90004eeaUL
#define SYSCALL_os_perso_derive_and_set_seed_ID_IN 0x60004fbdUL
#define SYSCALL_os_perso_derive_and_set_seed_ID_OUT 0x90004fcfUL
#define SYSCALL_os_perso_set_words_ID_IN 0x60005018UL
#define SYSCALL_os_perso_set_words_ID_OUT 0x900050eaUL
#define SYSCALL_os_perso_finalize_ID_IN 0x60005180UL
#define SYSCALL_os_perso_finalize_ID_OUT 0x90005154UL
#define SYSCALL_os_perso_isonboarded_ID_IN 0x6000529aUL
#define SYSCALL_os_perso_isonboarded_ID_OUT 0x900052d5UL
#define SYSCALL_os_perso_derive_node_bip32_ID_IN 0x600053baUL
#define SYSCALL_os_perso_derive_node_bip32_ID_OUT 0x9000531eUL
#define SYSCALL_os_perso_derive_node_bip32_seed_key_ID_IN 0x600054fbUL
#define SYSCALL_os_perso_derive_node_bip32_seed_key_ID_OUT 0x900054e7UL
#define SYSCALL_os_endorsement_get_code_hash_ID_IN 0x6000550fUL
#define SYSCALL_os_endorsement_get_code_hash_ID_OUT 0x900055a1UL
#define SYSCALL_os_endorsement_get_public_key_ID_IN 0x600056f3UL
#define SYSCALL_os_endorsement_get_public_key_ID_OUT 0x90005699UL
#define SYSCALL_os_endorsement_get_public_key_certificate_ID_IN 0x6000574cUL
#define SYSCALL_os_endorsement_get_public_key_certificate_ID_OUT 0x9000577fUL
#define SYSCALL_os_endorsement_key1_get_app_secret_ID_IN 0x6000585cUL
#define SYSCALL_os_endorsement_key1_get_app_secret_ID_OUT 0x90005860UL
#define SYSCALL_os_endorsement_key1_sign_data_ID_IN 0x600059d8UL
#define SYSCALL_os_endorsement_key1_sign_data_ID_OUT 0x9000592bUL
#define SYSCALL_os_endorsement_key2_derive_sign_data_ID_IN 0x60005a4aUL
#define SYSCALL_os_endorsement_key2_derive_sign_data_ID_OUT 0x90005a3eUL
#define SYSCALL_os_global_pin_is_validated_ID_IN 0x60005b89UL
#define SYSCALL_os_global_pin_is_validated_ID_OUT 0x90005b45UL
#define SYSCALL_os_global_pin_check_ID_IN 0x60005c6fUL
#define SYSCALL_os_global_pin_check_ID_OUT 0x90005c1eUL
#define SYSCALL_os_global_pin_invalidate_ID_IN 0x60005dd0UL
#define SYSCALL_os_global_pin_invalidate_ID_OUT 0x90005dfbUL
#define SYSCALL_os_global_pin_retries_ID_IN 0x60005e59UL
#define SYSCALL_os_global_pin_retries_ID_OUT 0x90005e18UL
#define SYSCALL_os_registry_count_ID_IN 0x60005f40UL
#define SYSCALL_os_registry_count_ID_OUT 0x90005f06UL
#define SYSCALL_os_registry_get_ID_IN 0x60006065UL
#define SYSCALL_os_registry_get_ID_OUT 0x900060b2UL
#define SYSCALL_os_sched_exec_ID_IN 0x60006114UL
#define SYSCALL_os_sched_exec_ID_OUT 0x9000619fUL
#define SYSCALL_os_sched_exit_ID_IN 0x600062e1UL
#define SYSCALL_os_sched_exit_ID_OUT 0x9000626fUL
#define SYSCALL_os_ux_register_ID_IN 0x60006315UL
#define SYSCALL_os_ux_register_ID_OUT 0x900063b9UL
#define SYSCALL_os_ux_ID_IN 0x60006458UL
#define SYSCALL_os_ux_ID_OUT 0x9000641fUL
#define SYSCALL_os_lib_call_ID_IN 0x6000650bUL
#define SYSCALL_os_lib_call_ID_OUT 0x90006515UL
#define SYSCALL_os_lib_end_ID_IN 0x600066c8UL
#define SYSCALL_os_lib_end_ID_OUT 0x900066e3UL
#define SYSCALL_os_lib_throw_ID_IN 0x60006745UL
#define SYSCALL_os_lib_throw_ID_OUT 0x90006787UL
#define SYSCALL_os_flags_ID_IN 0x6000686eUL
#define SYSCALL_os_flags_ID_OUT 0x9000687fUL
#define SYSCALL_os_version_ID_IN 0x600069b8UL
#define SYSCALL_os_version_ID_OUT 0x900069c4UL
#define SYSCALL_os_seph_features_ID_IN 0x60006ad6UL
#define SYSCALL_os_seph_features_ID_OUT 0x90006a44UL
#define SYSCALL_os_seph_version_ID_IN 0x60006bacUL
#define SYSCALL_os_seph_version_ID_OUT 0x90006b5dUL
#define SYSCALL_os_setting_get_ID_IN 0x60006cc5UL
#define SYSCALL_os_setting_get_ID_OUT 0x90006cafUL
#define SYSCALL_os_setting_set_ID_IN 0x60006d96UL
#define SYSCALL_os_setting_set_ID_OUT 0x90006da5UL
#define SYSCALL_os_get_memory_info_ID_IN 0x60006e63UL
#define SYSCALL_os_get_memory_info_ID_OUT 0x90006ecbUL
#define SYSCALL_os_registry_get_tag_ID_IN 0x60006f51UL
#define SYSCALL_os_registry_get_tag_ID_OUT 0x90006f89UL
#define SYSCALL_os_registry_get_current_app_tag_ID_IN 0x600070d4UL
#define SYSCALL_os_registry_get_current_app_tag_ID_OUT 0x90007087UL
#define SYSCALL_os_customca_verify_ID_IN 0x60007161UL
#define SYSCALL_os_customca_verify_ID_OUT 0x90007182UL
#define SYSCALL_io_seproxyhal_spi_send_ID_IN 0x6000721cUL
#define SYSCALL_io_seproxyhal_spi_send_ID_OUT 0x900072f3UL
#define SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN 0x600073cfUL
#define SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT 0x9000737fUL
#define SYSCALL_io_seproxyhal_spi_recv_ID_IN 0x600074d1UL
#define SYSCALL_io_seproxyhal_spi_recv_ID_OUT 0x9000742bUL
#endif // SYSCALL_DEFS_H
