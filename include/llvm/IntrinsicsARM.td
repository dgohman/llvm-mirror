//===- IntrinsicsARM.td - Defines ARM intrinsics -----------*- tablegen -*-===//
// 
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
// 
//===----------------------------------------------------------------------===//
//
// This file defines all of the ARM-specific intrinsics.
//
//===----------------------------------------------------------------------===//


//===----------------------------------------------------------------------===//
// TLS

let TargetPrefix = "arm" in {  // All intrinsics start with "llvm.arm.".
  def int_arm_thread_pointer : GCCBuiltin<"__builtin_thread_pointer">,
              Intrinsic<[llvm_ptr_ty], [], [IntrNoMem]>;
}

//===----------------------------------------------------------------------===//
// Saturating Arithmentic

let TargetPrefix = "arm" in {  // All intrinsics start with "llvm.arm.".
  def int_arm_qadd : GCCBuiltin<"__builtin_arm_qadd">,
              Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty],
                        [IntrNoMem, Commutative]>;
  def int_arm_qsub : GCCBuiltin<"__builtin_arm_qsub">,
              Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty], [IntrNoMem]>;
  def int_arm_ssat : GCCBuiltin<"__builtin_arm_ssat">,
              Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty], [IntrNoMem]>;
  def int_arm_usat : GCCBuiltin<"__builtin_arm_usat">,
              Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty], [IntrNoMem]>;
}

//===----------------------------------------------------------------------===//
// Advanced SIMD (NEON)

let TargetPrefix = "arm" in {  // All intrinsics start with "llvm.arm.".

  // The following classes do not correspond directly to GCC builtins.
  class Neon_1Arg_Intrinsic
    : Intrinsic<[llvm_anyvector_ty], [LLVMMatchType<0>], [IntrNoMem]>;
  class Neon_1Arg_Narrow_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMExtendedElementVectorType<0>], [IntrNoMem]>;
  class Neon_1Arg_Long_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMTruncatedElementVectorType<0>], [IntrNoMem]>;
  class Neon_2Arg_Intrinsic
    : Intrinsic<[llvm_anyvector_ty], [LLVMMatchType<0>, LLVMMatchType<0>],
                [IntrNoMem]>;
  class Neon_2Arg_Narrow_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMExtendedElementVectorType<0>,
                 LLVMExtendedElementVectorType<0>],
                [IntrNoMem]>;
  class Neon_2Arg_Long_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMTruncatedElementVectorType<0>,
                 LLVMTruncatedElementVectorType<0>],
                [IntrNoMem]>;
  class Neon_2Arg_Wide_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>, LLVMTruncatedElementVectorType<0>],
                [IntrNoMem]>;
  class Neon_3Arg_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>, LLVMMatchType<0>, LLVMMatchType<0>],
                [IntrNoMem]>;
  class Neon_3Arg_Long_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>,
                 LLVMTruncatedElementVectorType<0>,
                 LLVMTruncatedElementVectorType<0>],
                [IntrNoMem]>;
  class Neon_CvtFxToFP_Intrinsic
    : Intrinsic<[llvm_anyfloat_ty], [llvm_anyint_ty, llvm_i32_ty], [IntrNoMem]>;
  class Neon_CvtFPToFx_Intrinsic
    : Intrinsic<[llvm_anyint_ty], [llvm_anyfloat_ty, llvm_i32_ty], [IntrNoMem]>;

  // The table operands for VTBL and VTBX consist of 1 to 4 v8i8 vectors.
  // Besides the table, VTBL has one other v8i8 argument and VTBX has two.
  // Overall, the classes range from 2 to 6 v8i8 arguments.
  class Neon_Tbl2Arg_Intrinsic
    : Intrinsic<[llvm_v8i8_ty],
                [llvm_v8i8_ty, llvm_v8i8_ty], [IntrNoMem]>;
  class Neon_Tbl3Arg_Intrinsic
    : Intrinsic<[llvm_v8i8_ty],
                [llvm_v8i8_ty, llvm_v8i8_ty, llvm_v8i8_ty], [IntrNoMem]>;
  class Neon_Tbl4Arg_Intrinsic
    : Intrinsic<[llvm_v8i8_ty],
                [llvm_v8i8_ty, llvm_v8i8_ty, llvm_v8i8_ty, llvm_v8i8_ty],
                [IntrNoMem]>;
  class Neon_Tbl5Arg_Intrinsic
    : Intrinsic<[llvm_v8i8_ty],
                [llvm_v8i8_ty, llvm_v8i8_ty, llvm_v8i8_ty, llvm_v8i8_ty,
                 llvm_v8i8_ty], [IntrNoMem]>;
  class Neon_Tbl6Arg_Intrinsic
    : Intrinsic<[llvm_v8i8_ty],
                [llvm_v8i8_ty, llvm_v8i8_ty, llvm_v8i8_ty, llvm_v8i8_ty,
                 llvm_v8i8_ty, llvm_v8i8_ty], [IntrNoMem]>;
}

// Arithmetic ops

let Properties = [IntrNoMem, Commutative] in {

  // Vector Add.
  def int_arm_neon_vhadds : Neon_2Arg_Intrinsic;
  def int_arm_neon_vhaddu : Neon_2Arg_Intrinsic;
  def int_arm_neon_vrhadds : Neon_2Arg_Intrinsic;
  def int_arm_neon_vrhaddu : Neon_2Arg_Intrinsic;
  def int_arm_neon_vqadds : Neon_2Arg_Intrinsic;
  def int_arm_neon_vqaddu : Neon_2Arg_Intrinsic;
  def int_arm_neon_vaddhn : Neon_2Arg_Narrow_Intrinsic;
  def int_arm_neon_vraddhn : Neon_2Arg_Narrow_Intrinsic;
  def int_arm_neon_vaddls : Neon_2Arg_Long_Intrinsic;
  def int_arm_neon_vaddlu : Neon_2Arg_Long_Intrinsic;
  def int_arm_neon_vaddws : Neon_2Arg_Wide_Intrinsic;
  def int_arm_neon_vaddwu : Neon_2Arg_Wide_Intrinsic;

  // Vector Multiply.
  def int_arm_neon_vmulp : Neon_2Arg_Intrinsic;
  def int_arm_neon_vqdmulh : Neon_2Arg_Intrinsic;
  def int_arm_neon_vqrdmulh : Neon_2Arg_Intrinsic;
  def int_arm_neon_vmulls : Neon_2Arg_Long_Intrinsic;
  def int_arm_neon_vmullu : Neon_2Arg_Long_Intrinsic;
  def int_arm_neon_vmullp : Neon_2Arg_Long_Intrinsic;
  def int_arm_neon_vqdmull : Neon_2Arg_Long_Intrinsic;

  // Vector Multiply and Accumulate/Subtract.
  def int_arm_neon_vmlals : Neon_3Arg_Long_Intrinsic;
  def int_arm_neon_vmlalu : Neon_3Arg_Long_Intrinsic;
  def int_arm_neon_vmlsls : Neon_3Arg_Long_Intrinsic;
  def int_arm_neon_vmlslu : Neon_3Arg_Long_Intrinsic;
  def int_arm_neon_vqdmlal : Neon_3Arg_Long_Intrinsic;
  def int_arm_neon_vqdmlsl : Neon_3Arg_Long_Intrinsic;

  // Vector Maximum.
  def int_arm_neon_vmaxs : Neon_2Arg_Intrinsic;
  def int_arm_neon_vmaxu : Neon_2Arg_Intrinsic;

  // Vector Minimum.
  def int_arm_neon_vmins : Neon_2Arg_Intrinsic;
  def int_arm_neon_vminu : Neon_2Arg_Intrinsic;

  // Vector Reciprocal Step.
  def int_arm_neon_vrecps : Neon_2Arg_Intrinsic;

  // Vector Reciprocal Square Root Step.
  def int_arm_neon_vrsqrts : Neon_2Arg_Intrinsic;
}

// Vector Subtract.
def int_arm_neon_vhsubs : Neon_2Arg_Intrinsic;
def int_arm_neon_vhsubu : Neon_2Arg_Intrinsic;
def int_arm_neon_vqsubs : Neon_2Arg_Intrinsic;
def int_arm_neon_vqsubu : Neon_2Arg_Intrinsic;
def int_arm_neon_vsubhn : Neon_2Arg_Narrow_Intrinsic;
def int_arm_neon_vrsubhn : Neon_2Arg_Narrow_Intrinsic;
def int_arm_neon_vsubls : Neon_2Arg_Long_Intrinsic;
def int_arm_neon_vsublu : Neon_2Arg_Long_Intrinsic;
def int_arm_neon_vsubws : Neon_2Arg_Wide_Intrinsic;
def int_arm_neon_vsubwu : Neon_2Arg_Wide_Intrinsic;

// Vector Absolute Compare.
let TargetPrefix = "arm" in {
  def int_arm_neon_vacged : Intrinsic<[llvm_v2i32_ty],
                                      [llvm_v2f32_ty, llvm_v2f32_ty],
                                      [IntrNoMem]>;
  def int_arm_neon_vacgeq : Intrinsic<[llvm_v4i32_ty],
                                      [llvm_v4f32_ty, llvm_v4f32_ty],
                                      [IntrNoMem]>;
  def int_arm_neon_vacgtd : Intrinsic<[llvm_v2i32_ty],
                                      [llvm_v2f32_ty, llvm_v2f32_ty],
                                      [IntrNoMem]>;
  def int_arm_neon_vacgtq : Intrinsic<[llvm_v4i32_ty],
                                      [llvm_v4f32_ty, llvm_v4f32_ty],
                                      [IntrNoMem]>;
}

// Vector Absolute Differences.
def int_arm_neon_vabds : Neon_2Arg_Intrinsic;
def int_arm_neon_vabdu : Neon_2Arg_Intrinsic;
def int_arm_neon_vabdls : Neon_2Arg_Long_Intrinsic;
def int_arm_neon_vabdlu : Neon_2Arg_Long_Intrinsic;

// Vector Absolute Difference and Accumulate.
def int_arm_neon_vabas : Neon_3Arg_Intrinsic;
def int_arm_neon_vabau : Neon_3Arg_Intrinsic;
def int_arm_neon_vabals : Neon_3Arg_Long_Intrinsic;
def int_arm_neon_vabalu : Neon_3Arg_Long_Intrinsic;

// Vector Pairwise Add.
def int_arm_neon_vpadd : Neon_2Arg_Intrinsic;

// Vector Pairwise Add Long.
// Note: This is different than the other "long" NEON intrinsics because
// the result vector has half as many elements as the source vector.
// The source and destination vector types must be specified separately.
let TargetPrefix = "arm" in {
  def int_arm_neon_vpaddls : Intrinsic<[llvm_anyvector_ty], [llvm_anyvector_ty],
                                       [IntrNoMem]>;
  def int_arm_neon_vpaddlu : Intrinsic<[llvm_anyvector_ty], [llvm_anyvector_ty],
                                       [IntrNoMem]>;
}

// Vector Pairwise Add and Accumulate Long.
// Note: This is similar to vpaddl but the destination vector also appears
// as the first argument.
let TargetPrefix = "arm" in {
  def int_arm_neon_vpadals : Intrinsic<[llvm_anyvector_ty],
                                       [LLVMMatchType<0>, llvm_anyvector_ty],
                                       [IntrNoMem]>;
  def int_arm_neon_vpadalu : Intrinsic<[llvm_anyvector_ty],
                                       [LLVMMatchType<0>, llvm_anyvector_ty],
                                       [IntrNoMem]>;
}

// Vector Pairwise Maximum and Minimum.
def int_arm_neon_vpmaxs : Neon_2Arg_Intrinsic;
def int_arm_neon_vpmaxu : Neon_2Arg_Intrinsic;
def int_arm_neon_vpmins : Neon_2Arg_Intrinsic;
def int_arm_neon_vpminu : Neon_2Arg_Intrinsic;

// Vector Shifts:
//
// The various saturating and rounding vector shift operations need to be
// represented by intrinsics in LLVM, and even the basic VSHL variable shift
// operation cannot be safely translated to LLVM's shift operators.  VSHL can
// be used for both left and right shifts, or even combinations of the two,
// depending on the signs of the shift amounts.  It also has well-defined
// behavior for shift amounts that LLVM leaves undefined.  Only basic shifts
// by constants can be represented with LLVM's shift operators.
//
// The shift counts for these intrinsics are always vectors, even for constant
// shifts, where the constant is replicated.  For consistency with VSHL (and
// other variable shift instructions), left shifts have positive shift counts
// and right shifts have negative shift counts.  This convention is also used
// for constant right shift intrinsics, and to help preserve sanity, the
// intrinsic names use "shift" instead of either "shl" or "shr".  Where
// applicable, signed and unsigned versions of the intrinsics are
// distinguished with "s" and "u" suffixes.  A few NEON shift instructions,
// such as VQSHLU, take signed operands but produce unsigned results; these
// use a "su" suffix.

// Vector Shift.
def int_arm_neon_vshifts : Neon_2Arg_Intrinsic;
def int_arm_neon_vshiftu : Neon_2Arg_Intrinsic;
def int_arm_neon_vshiftls : Neon_2Arg_Long_Intrinsic;
def int_arm_neon_vshiftlu : Neon_2Arg_Long_Intrinsic;
def int_arm_neon_vshiftn : Neon_2Arg_Narrow_Intrinsic;

// Vector Rounding Shift.
def int_arm_neon_vrshifts : Neon_2Arg_Intrinsic;
def int_arm_neon_vrshiftu : Neon_2Arg_Intrinsic;
def int_arm_neon_vrshiftn : Neon_2Arg_Narrow_Intrinsic;

// Vector Saturating Shift.
def int_arm_neon_vqshifts : Neon_2Arg_Intrinsic;
def int_arm_neon_vqshiftu : Neon_2Arg_Intrinsic;
def int_arm_neon_vqshiftsu : Neon_2Arg_Intrinsic;
def int_arm_neon_vqshiftns : Neon_2Arg_Narrow_Intrinsic;
def int_arm_neon_vqshiftnu : Neon_2Arg_Narrow_Intrinsic;
def int_arm_neon_vqshiftnsu : Neon_2Arg_Narrow_Intrinsic;

// Vector Saturating Rounding Shift.
def int_arm_neon_vqrshifts : Neon_2Arg_Intrinsic;
def int_arm_neon_vqrshiftu : Neon_2Arg_Intrinsic;
def int_arm_neon_vqrshiftns : Neon_2Arg_Narrow_Intrinsic;
def int_arm_neon_vqrshiftnu : Neon_2Arg_Narrow_Intrinsic;
def int_arm_neon_vqrshiftnsu : Neon_2Arg_Narrow_Intrinsic;

// Vector Shift and Insert.
def int_arm_neon_vshiftins : Neon_3Arg_Intrinsic;

// Vector Absolute Value and Saturating Absolute Value.
def int_arm_neon_vabs : Neon_1Arg_Intrinsic;
def int_arm_neon_vqabs : Neon_1Arg_Intrinsic;

// Vector Saturating Negate.
def int_arm_neon_vqneg : Neon_1Arg_Intrinsic;

// Vector Count Leading Sign/Zero Bits.
def int_arm_neon_vcls : Neon_1Arg_Intrinsic;
def int_arm_neon_vclz : Neon_1Arg_Intrinsic;

// Vector Count One Bits.
def int_arm_neon_vcnt : Neon_1Arg_Intrinsic;

// Vector Reciprocal Estimate.
def int_arm_neon_vrecpe : Neon_1Arg_Intrinsic;

// Vector Reciprocal Square Root Estimate.
def int_arm_neon_vrsqrte : Neon_1Arg_Intrinsic;

// Vector Conversions Between Floating-point and Fixed-point.
def int_arm_neon_vcvtfp2fxs : Neon_CvtFPToFx_Intrinsic;
def int_arm_neon_vcvtfp2fxu : Neon_CvtFPToFx_Intrinsic;
def int_arm_neon_vcvtfxs2fp : Neon_CvtFxToFP_Intrinsic;
def int_arm_neon_vcvtfxu2fp : Neon_CvtFxToFP_Intrinsic;

// Narrowing and Lengthening Vector Moves.
def int_arm_neon_vmovn : Neon_1Arg_Narrow_Intrinsic;
def int_arm_neon_vqmovns : Neon_1Arg_Narrow_Intrinsic;
def int_arm_neon_vqmovnu : Neon_1Arg_Narrow_Intrinsic;
def int_arm_neon_vqmovnsu : Neon_1Arg_Narrow_Intrinsic;
def int_arm_neon_vmovls : Neon_1Arg_Long_Intrinsic;
def int_arm_neon_vmovlu : Neon_1Arg_Long_Intrinsic;

// Vector Table Lookup.
// The first 1-4 arguments are the table.
def int_arm_neon_vtbl1 : Neon_Tbl2Arg_Intrinsic;
def int_arm_neon_vtbl2 : Neon_Tbl3Arg_Intrinsic;
def int_arm_neon_vtbl3 : Neon_Tbl4Arg_Intrinsic;
def int_arm_neon_vtbl4 : Neon_Tbl5Arg_Intrinsic;

// Vector Table Extension.
// Some elements of the destination vector may not be updated, so the original
// value of that vector is passed as the first argument.  The next 1-4
// arguments after that are the table.
def int_arm_neon_vtbx1 : Neon_Tbl3Arg_Intrinsic;
def int_arm_neon_vtbx2 : Neon_Tbl4Arg_Intrinsic;
def int_arm_neon_vtbx3 : Neon_Tbl5Arg_Intrinsic;
def int_arm_neon_vtbx4 : Neon_Tbl6Arg_Intrinsic;

let TargetPrefix = "arm" in {

  // De-interleaving vector loads from N-element structures.
  def int_arm_neon_vld1 : Intrinsic<[llvm_anyvector_ty],
                                    [llvm_ptr_ty], [IntrReadArgMem]>;
  def int_arm_neon_vld2 : Intrinsic<[llvm_anyvector_ty, LLVMMatchType<0>],
                                    [llvm_ptr_ty], [IntrReadArgMem]>;
  def int_arm_neon_vld3 : Intrinsic<[llvm_anyvector_ty, LLVMMatchType<0>,
                                     LLVMMatchType<0>],
                                    [llvm_ptr_ty], [IntrReadArgMem]>;
  def int_arm_neon_vld4 : Intrinsic<[llvm_anyvector_ty, LLVMMatchType<0>,
                                     LLVMMatchType<0>, LLVMMatchType<0>],
                                    [llvm_ptr_ty], [IntrReadArgMem]>;

  // Vector load N-element structure to one lane.
  def int_arm_neon_vld2lane : Intrinsic<[llvm_anyvector_ty, LLVMMatchType<0>],
                                        [llvm_ptr_ty, LLVMMatchType<0>,
                                         LLVMMatchType<0>, llvm_i32_ty],
                                        [IntrReadArgMem]>;
  def int_arm_neon_vld3lane : Intrinsic<[llvm_anyvector_ty, LLVMMatchType<0>,
                                         LLVMMatchType<0>],
                                        [llvm_ptr_ty, LLVMMatchType<0>,
                                         LLVMMatchType<0>, LLVMMatchType<0>,
                                         llvm_i32_ty], [IntrReadArgMem]>;
  def int_arm_neon_vld4lane : Intrinsic<[llvm_anyvector_ty, LLVMMatchType<0>,
                                         LLVMMatchType<0>, LLVMMatchType<0>],
                                        [llvm_ptr_ty, LLVMMatchType<0>,
                                         LLVMMatchType<0>, LLVMMatchType<0>,
                                         LLVMMatchType<0>, llvm_i32_ty],
                                        [IntrReadArgMem]>;

  // Interleaving vector stores from N-element structures.
  def int_arm_neon_vst1 : Intrinsic<[],
                                    [llvm_ptr_ty, llvm_anyvector_ty],
                                    [IntrWriteArgMem]>;
  def int_arm_neon_vst2 : Intrinsic<[],
                                    [llvm_ptr_ty, llvm_anyvector_ty,
                                     LLVMMatchType<0>], [IntrWriteArgMem]>;
  def int_arm_neon_vst3 : Intrinsic<[],
                                    [llvm_ptr_ty, llvm_anyvector_ty,
                                     LLVMMatchType<0>, LLVMMatchType<0>],
                                     [IntrWriteArgMem]>;
  def int_arm_neon_vst4 : Intrinsic<[],
                                    [llvm_ptr_ty, llvm_anyvector_ty,
                                     LLVMMatchType<0>, LLVMMatchType<0>,
                                     LLVMMatchType<0>], [IntrWriteArgMem]>;

  // Vector store N-element structure from one lane.
  def int_arm_neon_vst2lane : Intrinsic<[],
                                        [llvm_ptr_ty, llvm_anyvector_ty,
                                         LLVMMatchType<0>, llvm_i32_ty],
                                        [IntrWriteArgMem]>;
  def int_arm_neon_vst3lane : Intrinsic<[],
                                        [llvm_ptr_ty, llvm_anyvector_ty,
                                         LLVMMatchType<0>, LLVMMatchType<0>,
                                         llvm_i32_ty], [IntrWriteArgMem]>;
  def int_arm_neon_vst4lane : Intrinsic<[],
                                        [llvm_ptr_ty, llvm_anyvector_ty,
                                         LLVMMatchType<0>, LLVMMatchType<0>,
                                         LLVMMatchType<0>, llvm_i32_ty],
                                        [IntrWriteArgMem]>;
}
